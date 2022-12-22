import 'package:flutter/material.dart';
import '../models/game.dart';

class PreviousGameDetailsScreen extends StatelessWidget {
  Game game;
  PreviousGameDetailsScreen({required this.game});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              game.gameType,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
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
            Expanded(
              child: ListView(
                  children: game.keyMoments.reversed
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ListTile(
                              tileColor:
                                  const Color.fromARGB(112, 157, 151, 151),
                              title: Text(
                                e,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ))
                      .toList()),
            )
          ]),
        ));
  }
}
