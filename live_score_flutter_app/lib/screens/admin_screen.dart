import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/providers/auth_provider.dart';
import 'package:live_score_flutter_app/providers/games_admin_provider.dart';
import 'package:live_score_flutter_app/screens/create_game_screen.dart';
import 'package:live_score_flutter_app/screens/ongoing_games_screen.dart';
import 'package:live_score_flutter_app/utils.dart';
import 'package:live_score_flutter_app/widgets/game_card.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import 'edit_game_screen.dart';

class AdminScreen extends StatelessWidget {
  static const id = 'adminscreen';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
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
                              return const Text('Hello Loading...');
                            }
                          }),
                      TextButton(
                          onPressed: () async {
                            try {
                              await AuthProvider.logout();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                OngoingGamesScreen.id,
                                (Route<dynamic> route) => false,
                              );
                            } catch (e) {
                              print(e);
                              Utils.showSnackbar(
                                  'Something went wrong while logout');
                            }
                          },
                          child: const Text('Logout')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 0,
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AnnouncementDialogBox());
                        },
                        child: const Text(
                          'Announce Something 🔊',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: Provider.of<GamesAdminProvider>(context,listen: false).getAdminGames,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) => GameCard(
                          game: snapshot.data![index],
                          isAdminCard: true,
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
    );
  }
}

class AnnouncementDialogBox extends StatefulWidget {
  @override
  State<AnnouncementDialogBox> createState() => _AnnouncementDialogBoxState();
}

class _AnnouncementDialogBoxState extends State<AnnouncementDialogBox> {
  final messageController = TextEditingController();
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          icon: const Icon(Icons.announcement),
            title: TextField(
              controller: messageController,
              autofocus: true,
              decoration: const InputDecoration(hintText: "Enter your message"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ));
                    await Provider.of<GamesAdminProvider>(context,
                            listen: false)
                        .addAnnouncement(messageController.text);
                    Navigator.popUntil(context, ModalRoute.withName('adminscreen'));
                  },
                  child: const Text('Announce'))
            ],
          );
  }
}
