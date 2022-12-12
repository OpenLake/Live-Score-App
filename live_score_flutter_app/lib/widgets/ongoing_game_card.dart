import 'package:flutter/material.dart';

class OngoingGameCard extends StatelessWidget {
  String gameType;
  String nameTeam1;
  String nameTeam2;
  String scoreTeam1;
  String scoreTeam2;
  OngoingGameCard(
      {required this.gameType,
      required this.nameTeam1,
      required this.nameTeam2,
      required this.scoreTeam1,
      required this.scoreTeam2});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 200,
      width: 0.75*MediaQuery.of(context).size.width,
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(gameType),
        const SizedBox(
          height:30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [Text(nameTeam1),const SizedBox(height:20), Text(scoreTeam1)],
            ),
            Column(
              children: [Text(nameTeam2),const SizedBox(height:20), Text(scoreTeam2)],
            )
          ],
        ),
      ]),
    );
  }
}
