import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/screens/announcements_screen.dart';
import 'package:live_score_flutter_app/screens/auth_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        ListTile(
          title: const Text('Login/Signup'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AuthScreen.id);
          },
        ),
        ListTile(
          title: Text('Previous Games'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Announcements'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AnnouncementScreen.id);
          },
        )
      ]),
    );
  }
}
