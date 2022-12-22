import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/game.dart';

class GameCard extends StatelessWidget {
  Game game;
  VoidCallback? onPressed;
  bool isAdminCard;
  GameCard({required this.game, this.onPressed, this.isAdminCard = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        height: 210,
        decoration: const BoxDecoration(color: Color.fromARGB(124, 158, 158, 158)),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center, children: [
          isAdminCard
              ? const SizedBox()
              : Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                alignment: Alignment.center,
                height: 25,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Creator: ${game.creatorName}',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'College: ${game.college}',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal:16),
            child: Column(children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  game.gameType,
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
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
              Container(
                margin: const EdgeInsets.only(top: 35,bottom: 5),
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat('dd MMMM yyyy \n kk:mm')
                      .format(DateTime.parse(game.createdOn)),
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
