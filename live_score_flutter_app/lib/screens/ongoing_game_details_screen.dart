import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expandable_text/expandable_text.dart';
import '../models/game.dart';
import '../providers/games_users_provider.dart';

class OngoingGameDetailsScreen extends StatelessWidget {
  String gameId;
  OngoingGameDetailsScreen(this.gameId);

  Game game = Game();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(children: [
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
                        Container(
                          height: 0.18 * size.height,
                          width: 0.35 * size.width,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(game.team1.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style:
                                      const TextStyle(color: Colors.white)),
                              const SizedBox(height: 10.0),
                              Text(game.score1.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 40.0))
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "VS",
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          height: 0.18 * size.height,
                          width: 0.35 * size.width,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(game.team2.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style:
                                      const TextStyle(color: Colors.white)),
                              const SizedBox(height: 10.0),
                              Text(game.score2.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 40.0))
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ExpandableText(
                        game.description,
                        expandText: 'show more',
                        collapseText: 'show less',
                        maxLines: 1,
                        linkColor: Colors.blue,
                      ),
                    ),
                     const SizedBox(
                      height: 20,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Highlights",
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.w500))),
                    const SizedBox(
                      height: 8,
                    ),
                  ]),
                ),
                Expanded(
                  child: ListView(
                      children: game.keyMoments.reversed
                          .map((e) => Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ListTile(
                                  textColor: Colors.white,
                                  tileColor: const Color(0xDFEA3C3C),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  title: Text(e),
                                ),
                              ))
                          .toList()),
                ),
              ]),
            );
          }),
    );
  }
}
