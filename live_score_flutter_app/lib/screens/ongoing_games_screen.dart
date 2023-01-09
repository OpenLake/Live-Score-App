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
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Ongoing Games',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    CollegeDropdown(),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const OngoingGamesListWidget(),
            ]),
      ),
    );
  }
}

String selectedCollege = 'All';

class CollegeDropdown extends StatefulWidget {
  @override
  State<CollegeDropdown> createState() => _CollegeDropdownState();
}

class _CollegeDropdownState extends State<CollegeDropdown> {
  List<String> collegeList = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: Provider.of<GameUsersProvider>(context, listen: false)
            .getAllCollegesOngoing(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            collegeList = snapshot.data as List<String>;
            return DropdownButton(
              value: Provider.of<GameUsersProvider>(context, listen: false).getSelectedCollegeOngoing,
              items: ['All', ...collegeList]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                selectedCollege = value ?? 'All';

                Provider.of<GameUsersProvider>(context, listen: false)
                    .setSelectedCollegeOngoing(selectedCollege);
                setState(() {});
              });
          }
          else{
            return DropdownButton(
              value: 'All',
              items: ['All']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
              });
          }
          
        });
  }
}

class OngoingGamesListWidget extends StatelessWidget {
  const OngoingGamesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Provider.of<GameUsersProvider>(context).getOngoingGamesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child:
                    Text('Something went Wrong while fetching Ongoing Games'));
          }
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
            gamesList.sort((a,b) => -1*a.createdOn.compareTo(b.createdOn));
            
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
