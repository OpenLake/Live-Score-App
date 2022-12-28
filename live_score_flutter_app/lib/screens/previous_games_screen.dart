import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/screens/previous_game_details_screen.dart';
import 'package:live_score_flutter_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../providers/games_users_provider.dart';
import '../widgets/game_card.dart';

class PreviousGamesScreen extends StatelessWidget {
  static const id = 'previousgames';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Score'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:32.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Previous Games',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 25,
          ),
          PreviousGamesListWidget(),
        ]),
      ),
    );
  }
}

class PreviousGamesListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<GameUsersProvider>(context).getPreviousGames(),
        builder: (context, snapshot) {
          List<Game> gamesList = [];
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            gamesList = List<Game>.from(
                snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Game.fromJson(data);
            }).toList());
            if (gamesList.isEmpty) {
              return const Center(
                child: Text('There are no Previous games'),
              );
            }
          }

          return Expanded(
            child: ListView.builder(
              itemCount: gamesList.length,
              itemBuilder: (context, index) => GameCard(
                game: gamesList[index],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PreviousGameDetailsScreen(game: gamesList[index]),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
