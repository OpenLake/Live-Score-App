import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/dummydata.dart';
import 'package:live_score_flutter_app/providers/auth_provider.dart';
import 'package:live_score_flutter_app/providers/games_admin_provider.dart';
import 'package:live_score_flutter_app/screens/create_game_screen.dart';
import 'package:live_score_flutter_app/screens/ongoing_games_screen.dart';
import 'package:live_score_flutter_app/widgets/ongoing_game_card.dart';
import 'package:provider/provider.dart';

import '../models/game.dart';
import 'edit_game_screen.dart';

class UserScreen extends StatelessWidget {
  static const id = 'userscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateGameScreen.id);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder(
                      future: AuthProvider.currentUser,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text('Hello ${snapshot.data?.name}');
                        } else {
                          return Text('Hello Loading...');
                        }
                      }),
                  TextButton(
                      onPressed: () async {
                        try {
                          await AuthProvider.logout();
                          Navigator.pushNamed(context, OngoingGamesScreen.id);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Text('Logout')),
                ],
              ),
              FutureBuilder(
                  future:
                      Provider.of<GamesAdminProvider>(context).getAdminGames,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) => OngoingGameCard(
                            game: snapshot.data![index],
                            onPressed: () {
                              Provider.of<GamesAdminProvider>(context,
                                      listen: false)
                                  .setCurrentGame(snapshot.data![index]);
                              Map<String, Game> args = {
                                'game': snapshot.data![index]
                              };
                              Navigator.pushNamed(context, EditGameScreen.id,
                                  arguments: args);
                            },
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
