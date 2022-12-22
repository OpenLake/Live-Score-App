import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../models/game.dart';

class GameUsersProvider extends ChangeNotifier {
  final _dbOngoingGamesRT = FirebaseDatabase.instance.ref("OngoingGames/");
  final _db = FirebaseFirestore.instance.collection('PreviousGames/');

  Stream getOngoingGamesStream() {
    return _dbOngoingGamesRT.onValue;
  }

  Stream getChoosenGameStream(String gameId) {
    return _dbOngoingGamesRT.child(gameId).onValue;
  }

  Future getPreviousGames() async{
    return await _db.get();
  }

}
