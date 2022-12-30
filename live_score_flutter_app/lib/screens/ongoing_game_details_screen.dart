import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game.dart';
import '../providers/games_users_provider.dart';

class OngoingGameDetailsScreen extends StatelessWidget {
  String gameId;
  OngoingGameDetailsScreen(this.gameId);

  Game game = Game();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: Provider.of<GameUsersProvider>(context)
              .getChoosenGameStream(gameId),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final temp = (snapshot.data as DatabaseEvent);
              if (temp.snapshot.exists) {
                final gameMap = temp.snapshot.value as Map<dynamic, dynamic>;
                game = Game.fromJson(gameMap);
              } else {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Game has Ended. Please look into *Previous Games Section*',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            }
            return Column(children: [
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    game.gameType,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(game.team1),
                          const SizedBox(height: 20),
                          Text(game.score1.toString())
                        ],
                      ),
                      Column(
                        children: [
                          Text(game.team2),
                          const SizedBox(height: 20),
                          Text(game.score2.toString())
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ]),
              ),
              Expanded(
                child: ListView(
                    children: game.keyMoments.reversed
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: ListTile(
                                tileColor: Color.fromARGB(112, 157, 151, 151),
                                title: Text(
                                  e,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ))
                        .toList()),
              ),
            ]);
          }),
    );
  }
}
