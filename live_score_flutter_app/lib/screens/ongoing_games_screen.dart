import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/providers/games_users_provider.dart';
import 'package:live_score_flutter_app/screens/ongoing_game_details_screen.dart';
import 'package:live_score_flutter_app/widgets/app_drawer.dart';
import 'package:live_score_flutter_app/widgets/game_card.dart';
import 'package:provider/provider.dart';

import '../models/game.dart';

class OngoingGamesScreen extends StatelessWidget {
  static const id = 'ongoinggamesscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Score'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 10,
              ),
              Text(
                'Ongoing Games',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 25,
              ),
              OngoingGamesListWidget(),
            ]),
      ),
    );
  }
}

class OngoingGamesListWidget extends StatelessWidget {
  const OngoingGamesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Provider.of<GameUsersProvider>(context).getOngoingGamesStream(),
        builder: (context, snapshot) {
          List<Game> gamesList = [];
          if (snapshot.hasData && snapshot.data != null) {
            final temp = (snapshot.data as DatabaseEvent);
            if (temp.snapshot.exists) {
              final gamesMap = temp.snapshot.value as Map<dynamic, dynamic>;
              gamesMap.forEach((key, value) {
                if (value != null) {
                  final game = Game.fromJson(value as Map<dynamic, dynamic>);
                  gamesList.add(game);
                }
              });
            }
            if (gamesList.isEmpty) {
              return const Center(
                child: Text(
                  'There are no Ongoing games currently🤧',
                  textAlign: TextAlign.center,
                ),
              );
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
                                OngoingGameDetailsScreen(gamesList[index].id)));
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
