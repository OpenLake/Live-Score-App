import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/screens/create_game_screen.dart';
import 'package:live_score_flutter_app/screens/ongoing_games_screen.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});
  static const id = 'userscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateGameScreen.id);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text('Hello User'),
              TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, OngoingGamesScreen.id);
                  },
                  child: const Text('Logout')),
            ],
          ),
          Text('This is User screen to create games'),
        ],
      ),
    );
  }
}
