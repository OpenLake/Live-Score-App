import 'package:flutter/material.dart';
import '../models/game.dart';

class PreviousGameDetailsScreen extends StatefulWidget {
  Game game;
  PreviousGameDetailsScreen({required this.game});

  @override
  State<PreviousGameDetailsScreen> createState() => _PreviousGameDetailsScreenState();
}

class _PreviousGameDetailsScreenState extends State<PreviousGameDetailsScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.game.gameType,
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
                            Text(widget.game.team1),
                            const SizedBox(height: 20),
                            Text(widget.game.score1.toString())
                          ],
                        ),
                        Column(
                          children: [
                            Text(widget.game.team2),
                            const SizedBox(height: 20),
                            Text(widget.game.score2.toString())
                          ],
                        )
                      ],
                    ),
                  ]),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView(
                  children: widget.game.keyMoments.reversed
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
          ],
        ));
  }
}
