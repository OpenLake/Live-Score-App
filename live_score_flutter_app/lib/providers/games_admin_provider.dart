import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:live_score_flutter_app/models/announcement.dart';
import 'package:live_score_flutter_app/providers/auth_provider.dart';
import 'package:live_score_flutter_app/utils.dart';
import '../models/game.dart';
import 'package:http/http.dart' as http;

class GamesAdminProvider extends ChangeNotifier {
  final _db = FirebaseFirestore.instance.collection('PreviousGames/');
  final _dbAnnouncements =
      FirebaseFirestore.instance.collection('Announcements/');
  final _dbOngoingGamesRT = FirebaseDatabase.instance.ref("OngoingGames/");

  Game _currentGame = Game(
      creator: 'None',
      college: 'None',
      gameType: 'None',
      team1: 'None',
      team2: 'None');

  Game get currentGame {
    return _currentGame;
  }

  void setCurrentGame(Game game) {
    _currentGame = game;
    notifyListeners();
  }

  Future<void> sendNotificationToDevices(
      String title, String body, String topic) async {
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${dotenv.env["SERVER_KEY"]}',
        },
        body: jsonEncode({
          "condition": "'$topic' in topics || 'All' in topics",
          'notification': {
            'android_channel_id': 'pushnotificationapp',
            'title': title,
            'body': body,
          },
        }));
  }

  Future<void> addAnnouncement(String message) async {
    if (message == '') return;
    try {
      final myDoc = _dbAnnouncements.doc();
      final currentAdmin = await AuthProvider.currentUser;
      Announcement announcement = Announcement(
        message: message,
        createdOn: DateTime.now().toString(),
        creator: currentAdmin?.email ?? '',
        creatorName: currentAdmin?.name ?? '',
        collegeName: currentAdmin?.collegeName ?? '',
        id: myDoc.id,
      );
      await myDoc.set(announcement.toJson());
      await sendNotificationToDevices(
          '${announcement.creatorName} (${announcement.collegeName})',
          announcement.message,
          announcement.collegeName.replaceAll(' ', ''));
      Utils.showSnackbar('Your message was announced');
    } catch (e) {
      print(e);
      Utils.showSnackbar('Something went wrong while announcing');
    }
  }

  Future<List<Game>> get getAdminGames async {
    List<Game> gamesAdminList = [];
    try {
      final currentUser = await AuthProvider.currentUser;
      final snapshots = await _dbOngoingGamesRT
          .orderByChild('creator')
          .equalTo(currentUser?.email)
          .get();
      if (snapshots.exists) {
        Map<dynamic, dynamic> result = snapshots.value as Map<dynamic, dynamic>;
        gamesAdminList = result.values.map((e) {
          return Game.fromJson(e);
        }).toList();
      }
      return gamesAdminList;
    } catch (e) {
      print(e);
      Utils.showSnackbar('Something Went Wrong while fetching games');
      return [];
    }
  }

  Future<void> addGame(
      String team1, String team2, String description, String gameType) async {
    try {
      final currentUser = await AuthProvider.currentUser;
      Game game = Game(
          creator: currentUser!.email,
          creatorName: currentUser.name,
          college: currentUser.collegeName,
          description: description,
          gameType: gameType,
          team1: team1,
          team2: team2,
          createdOn: DateTime.now().toString());
      final myDoc = _dbOngoingGamesRT.push();
      await myDoc.set(game.toJson(myDoc.key!));
    } catch (e) {
      print(e);
      Utils.showSnackbar('Something went wrong while creating game');
    }
  }

  Future<void> changeScore(
      {bool isIncrease = true, bool isScore1 = true}) async {
    try {
      if (isScore1) {
        if (isIncrease) {
          await _dbOngoingGamesRT
              .child('${currentGame.id}/score1')
              .set(++_currentGame.score1);
        } else {
          await _dbOngoingGamesRT
              .child('${currentGame.id}/score1')
              .set(_currentGame.score1 > 0 ? --_currentGame.score1 : 0);
        }
      } else {
        if (isIncrease) {
          await _dbOngoingGamesRT
              .child('${currentGame.id}/score2')
              .set(++_currentGame.score2);
        } else {
          await _dbOngoingGamesRT
              .child('${currentGame.id}/score2')
              .set((_currentGame.score2) > 0 ? --_currentGame.score2 : 0);
        }
      }
      notifyListeners();
    } catch (e) {
      Utils.showSnackbar('Please check your internet connection');
    }
  }

  Future<void> sendKeyMoments(String message) async {
    if (message == '') return;
    try {
      List<dynamic> keyMomentsList =
          ((await _dbOngoingGamesRT.child('${currentGame.id}/keyMoments').get())
                  .value as List<dynamic>)
              .toList();

      keyMomentsList.add(message);
      await _dbOngoingGamesRT
          .child('${currentGame.id}/keyMoments')
          .set(keyMomentsList);
      // _currentGame.keyMoments.add(message);
      // notifyListeners();
    } catch (e) {
      print(e);
      Utils.showSnackbar('Something went wrong while sending key moments');
    }
  }

  Future<void> endGame(String winner) async {
    try {
      final snapshots = (await _dbOngoingGamesRT
          .orderByChild('id')
          .equalTo(_currentGame.id)
          .get());
      Map<dynamic, dynamic> result = snapshots.value as Map<dynamic, dynamic>;
      Map<dynamic, dynamic> myGame = result.values.elementAt(0);
      final mydoc = _db.doc();
      myGame['id'] = mydoc.id;
      myGame['winner'] = winner;
      Map<String, dynamic> mG = Map<String, dynamic>.from(myGame);
      await mydoc.set(mG);
      await _dbOngoingGamesRT.child(result.keys.elementAt(0)).remove();
    } catch (e) {
      print(e);
      Utils.showSnackbar('Something went wrong while ending game');
    }
  }
}
