import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/widgets/app_drawer.dart';
import 'package:live_score_flutter_app/widgets/ongoing_game_card.dart';
import 'package:live_score_flutter_app/dummydata.dart' as d;

class OngoingGamesScreen extends StatelessWidget {
  static final id = 'ongoinggamesscreen';
  List gamesList = d.gamesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Score'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const SizedBox(
            height: 50,
          ),
          const Text('Ongoing Games'),
          const SizedBox(height: 50,),
          Expanded(
            child: ListView.builder(
              itemCount: gamesList.length,
              itemBuilder: (context, index) {
              return OngoingGameCard(
                  gameType: gamesList[index].gameType,
                  nameTeam1: gamesList[index].nameTeam1,
                  nameTeam2: gamesList[index].nameTeam2,
                  scoreTeam1: gamesList[index].scoreTeam1,
                  scoreTeam2: gamesList[index].scoreTeam2);
            }),
          )
        ]),
      ),
    );
  }
}
