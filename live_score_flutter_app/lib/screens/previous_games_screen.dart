import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/providers/games_admin_provider.dart';
import 'package:live_score_flutter_app/screens/previous_game_details_screen.dart';
import 'package:live_score_flutter_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../providers/games_users_provider.dart';
import '../widgets/game_card.dart';

class PreviousGamesScreen extends StatelessWidget {
  static const id = 'previousgames';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Score'),
      ),
      drawer: const AppDrawer(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Previous Games',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              CollegeDropdown(),
            ],
          ),
        ),
        PreviousGamesListWidget(),
      ]),
    );
  }
}

String selectedCollege = 'All';

class CollegeDropdown extends StatefulWidget {
  @override
  State<CollegeDropdown> createState() => _CollegeDropdownState();
}

class _CollegeDropdownState extends State<CollegeDropdown> {
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: Provider.of<GameUsersProvider>(context, listen: false)
            .getAllCollegesPrevious(),
        builder: (context, snapshot) {
          List<String> collegeList = [];
          if (snapshot.hasData && snapshot.data != null) {
            collegeList = snapshot.data as List<String>;
            return DropdownButton(
            value: Provider.of<GameUsersProvider>(context, listen: false).getSelectedCollegePrevious,
              items: ['All', ...collegeList]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                selectedCollege = value ?? 'All';

                Provider.of<GameUsersProvider>(context, listen: false)
                    .setSelectedCollegePrevious(selectedCollege);
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



class PreviousGamesListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<GameUsersProvider>(context).getPreviousGames(),
        builder: (context, snapshot) {
          List<Game> gamesList = [];
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            gamesList = snapshot.data ?? [];
            if (gamesList.isEmpty) {
              return const Center(
                child: Text('There are no Previous games'),
              );
            }
          }

          return Expanded(
            child: ListView.builder(
              itemCount: gamesList.length,
              itemBuilder: (context, index) => GameCard(
                game: gamesList[index],
                isPreviousCard: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PreviousGameDetailsScreen(game: gamesList[index]),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
