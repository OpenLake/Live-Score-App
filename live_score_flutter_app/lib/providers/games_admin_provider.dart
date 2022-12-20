import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/providers/auth_provider.dart';
import 'package:live_score_flutter_app/utils.dart';
import '../models/game.dart';
import '../screens/user_screen.dart';

class GamesAdminProvider extends ChangeNotifier {
  final _db = FirebaseFirestore.instance.collection('PreviousGames/');
  final _dbOngoingGamesRT = FirebaseDatabase.instance.ref("OngoingGames/");

  Game _currentGame = Game(
      creator: 'None',
      college: 'None',
      gameType: 'None',
      team1: 'None',
      team2: 'None');
  String _currentGameWinner = 'Draw';

  Game get currentGame {
    return _currentGame;
  }

  void setCurrentGame(Game game) {
    _currentGame = game;
    notifyListeners();
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
      Utils.showSnackbar('Something Went Wrong');
      return [];
    }
  }

  Future<void> addGame(
      String team1, String team2, String description, String gameType) async {
    try {
      final currentUser = await AuthProvider.currentUser;
      Game game = Game(
          creator: currentUser!.email,
          college: currentUser.collegeName,
          description: description,
          gameType: gameType,
          team1: team1,
          team2: team2);
      final myDoc = _dbOngoingGamesRT.push();
      await myDoc.set(game.toJson(myDoc.key!));
    } catch (e) {
      print(e);
      Utils.showSnackbar('Something went wrong');
    }
  }

  Future<void> changeScore(
      {bool isIncrease = true, bool isScore1 = true}) async {
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
      Utils.showSnackbar('Something went wrong');
    }
  }
}
