import 'package:flutter/material.dart';

import '../models/game.dart';

class OngoingGameCard extends StatelessWidget {
  Game game;
  VoidCallback? onPressed;
  OngoingGameCard({required this.game,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 16),
        height: 200,
        width: 0.75 * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(border: Border.all()),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(game.gameType),
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
        ]),
      ),
    );
  }
}
