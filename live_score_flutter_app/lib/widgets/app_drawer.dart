import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/screens/announcements_screen.dart';
import 'package:live_score_flutter_app/screens/auth_screen.dart';
import 'package:live_score_flutter_app/screens/previous_games_screen.dart';

import '../screens/ongoing_games_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Hero(tag:"main-image",child: Image.asset("assets/sports_auth.png")),
        ),
        ListTile(
          leading: const Icon(Icons.person,color:Colors.blue),
          title: const Text('Login/Signup'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AuthScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.visibility_rounded,color:Colors.blue),
          title: const Text('Ongoing Games'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, OngoingGamesScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.history,color:Colors.blue),
          title: const Text('Previous Games'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, PreviousGamesScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.newspaper,color:Colors.blue),
          title: const Text('Announcements'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AnnouncementScreen.id);
          },
        )
      ]),
    );
  }
}
