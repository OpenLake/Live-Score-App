import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/screens/auth_screen.dart';
import 'package:live_score_flutter_app/screens/login_screen.dart';
import 'package:live_score_flutter_app/screens/ongoing_games_screen.dart';
import 'package:live_score_flutter_app/screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: OngoingGamesScreen.id,
        routes: {
          OngoingGamesScreen.id:(context) => OngoingGamesScreen(),
          AuthScreen.id:(context) => AuthScreen(),
          LoginScreen.id:(context)=>LoginScreen(),
          SignupScreen.id:(context)=>SignupScreen(),
        },
    );
  }
}
