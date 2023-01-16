import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:live_score_flutter_app/utils.dart';
import '../models/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameUsersProvider extends ChangeNotifier {
  final _dbOngoingGamesRT = FirebaseDatabase.instance.ref("OngoingGames/");
  final _db = FirebaseFirestore.instance.collection('PreviousGames/');
  final _dbUsers = FirebaseFirestore.instance.collection('users/');
  final _dbAnnouncements =
      FirebaseFirestore.instance.collection('Announcements/');
  final _dbSubscriptions =
      FirebaseFirestore.instance.collection('Subscription');

  String _selectedCollegePrevious = 'All';
  String _selectedCollegeOngoing = 'All';

  String get getSelectedCollegePrevious {
    return _selectedCollegePrevious;
  }

  String get getSelectedCollegeOngoing {
    return _selectedCollegeOngoing;
  }

  Stream getOngoingGamesStream() {
    if (_selectedCollegeOngoing == 'All') {
      return _dbOngoingGamesRT.onValue;
    }
    return _dbOngoingGamesRT
        .orderByChild('college')
        .equalTo(_selectedCollegeOngoing)
        .onValue;
  }

  Stream getChoosenGameStream(String gameId) {
    return _dbOngoingGamesRT.child(gameId).onValue;
  }

  void setSelectedCollegePrevious(college) {
    _selectedCollegePrevious = college;
    notifyListeners();
  }

  void setSelectedCollegeOngoing(college) {
    _selectedCollegeOngoing = college;
    notifyListeners();
  }

  Future<List<Game>> getPreviousGames() async {
    List<Game> gamesList = [];
    try {
      QuerySnapshot snapshot;
      if (_selectedCollegePrevious == 'All') {
        snapshot = await _db.get();
      } else {
        snapshot = await _db
            .where('college', isEqualTo: _selectedCollegePrevious)
            .get();
      }
      gamesList =
          List<Game>.from(snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return Game.fromJson(data);
      }).toList());

      gamesList.sort((a, b) => -1 * a.createdOn.compareTo(b.createdOn));
      return gamesList;
    } catch (e) {
      Utils.showSnackbar("Something went wrong while fetching Previous Games");
      return [];
    }
  }

  Future getAnnouncements() async {
    try {
      return await _dbAnnouncements.get();
    } catch (e) {
      print(e);
      Utils.showSnackbar('Something went wrong while fetching announcements');
      return;
    }
  }

  Future<List<String>> getAllCollegesPrevious() async {
    List<String> collegeList = [];
    final snapshotGames = await _db.get();
    collegeList =
        List<String>.from(snapshotGames.docs.map((e) => e['college']).toSet());
    return collegeList;
  }

  Future<List<String>> getAllCollegesOngoing() async {
    List<String> collegeList = [];
    try {
      final snapshotGames = await _dbOngoingGamesRT.get();
      if (snapshotGames.exists) {
        Map<dynamic, dynamic> result =
            snapshotGames.value as Map<dynamic, dynamic>;
        collegeList = List<String>.from(result.values.map((e) {
          return e['college'];
        }).toSet());
      }
    } catch (e) {
      Utils.showSnackbar("Something went wrong");
    }
    return collegeList;
  }

  Future<Map<String, bool>> getAllColleges() async {
    Map<String, bool> collegeMap = {};
    List<String> collegeList = [];
    try {
      final snapshotUsers = await _dbUsers.get();
      if (snapshotUsers.size > 0) {
        collegeList = List<String>.from(
            snapshotUsers.docs.map((e) => e['collegeName']).toSet());
      }
      for (String college in ['All', ...collegeList]) {
        collegeMap[college] = await isSubscribedToCollege(college);
      }
    } catch (e) {
      print(e);
      Utils.showSnackbar('Something went wrong, Check your network connection');
    }
    return collegeMap;
  }

  static Future<void> subscribeToAllIfFirstTime() async {
    try {
      final pref = await SharedPreferences.getInstance();
      if (pref.getBool('All') == null) {
        await FirebaseMessaging.instance.subscribeToTopic('All');
        await pref.setBool('All', true);
      }
    } catch (e) {
      print(e);
      Utils.showSnackbar('something went wrong');
    }
  }

  Future<void> subscribeToCollege(bool value, String college) async {
    college = college.replaceAll(' ', '');
    try {
      final pref = await SharedPreferences.getInstance();
      if (value) {
        await FirebaseMessaging.instance.subscribeToTopic(college);
        await pref.setBool(college, true);
      } else {
        await FirebaseMessaging.instance.unsubscribeFromTopic(college);
        await pref.setBool(college, false);
      }
    } catch (e) {
      print(e);
      Utils.showSnackbar(
          "Can't subscribe to the college. Check your connection");
    }
  }

  Future<bool> isSubscribedToCollege(String college) async {
    college = college.replaceAll(' ', '');
    bool isSubscribed = false;
    final pref = await SharedPreferences.getInstance();
    isSubscribed = pref.getBool(college) ?? false;
    return isSubscribed;
  }
}
