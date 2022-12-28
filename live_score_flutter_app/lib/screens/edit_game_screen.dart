import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/providers/games_admin_provider.dart';
import 'package:live_score_flutter_app/screens/user_screen.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';

late Game currentGame;

class EditGameScreen extends StatefulWidget {
  static const id = 'editgame';

  @override
  State<EditGameScreen> createState() => _EditGameScreenState();
}

class _EditGameScreenState extends State<EditGameScreen> {
  final keyMomentsTextController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    keyMomentsTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currentGame =
        Provider.of<GamesAdminProvider>(context, listen: false).currentGame;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currentGame.gameType,
                    style: const TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              EndGameDialogBox(currentGame: currentGame));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("End Game",
                        style: TextStyle(fontSize: 18.0)),
                  )
                ],
              ),
              const SizedBox(height: 30.0),
              ControlsBox(
                teamName: currentGame.team1,
                isScore1: true,
              ),
              const SizedBox(height: 20.0),
              ControlsBox(
                teamName: currentGame.team2,
                isScore1: false,
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: keyMomentsTextController,
                decoration: InputDecoration(
                  hintText: "Key moments",
                  fillColor: Colors.red,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () async {
                        await Provider.of<GamesAdminProvider>(context,
                                listen: false)
                            .sendKeyMoments(keyMomentsTextController.text);
                        keyMomentsTextController.clear();
                      },
                      icon: const Icon(Icons.send)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EndGameDialogBox extends StatefulWidget {
  Game currentGame;
  EndGameDialogBox({required this.currentGame});

  @override
  State<EndGameDialogBox> createState() => _EndGameDialogBoxState();
}

class _EndGameDialogBoxState extends State<EndGameDialogBox> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : AlertDialog(
            title: DropdownButton(
                value: currentGame.winner,
                onChanged: (value) {
                  setState(() {
                    currentGame.winner = value ?? 'Draw';
                  });
                },
                items: [
                  DropdownMenuItem(
                      value: widget.currentGame.team1,
                      child: Text(widget.currentGame.team1)),
                  DropdownMenuItem(
                      value: widget.currentGame.team2,
                      child: Text(widget.currentGame.team2)),
                  const DropdownMenuItem(value: "Draw", child: Text('Draw'))
                ]),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await Provider.of<GamesAdminProvider>(context,
                            listen: false)
                        .endGame(currentGame.winner);
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pushNamed(context, UserScreen.id);
                  },
                  child: const Text('End Game'))
            ],
          );
  }
}

class ControlsBox extends StatelessWidget {
  String teamName;
  bool isScore1;
  ControlsBox({
    this.teamName = '',
    this.isScore1 = true,
  });

  @override
  Widget build(BuildContext context) {
    Game currentGame = Provider.of<GamesAdminProvider>(context).currentGame;
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(width: 2.0),
      ),
      child: Column(
        children: [
          Text(
            teamName,
            style: const TextStyle(
              fontSize: 25.0,
            ),
          ),
          const SizedBox(height: 20.0),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  (isScore1 ? currentGame.score1 : currentGame.score2)
                      .toString(),
                  style: const TextStyle(
                    fontSize: 35.0,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Provider.of<GamesAdminProvider>(context, listen: false)
                            .changeScore(isIncrease: true, isScore1: isScore1);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 50.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Provider.of<GamesAdminProvider>(context, listen: false)
                            .changeScore(isIncrease: false, isScore1: isScore1);
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
