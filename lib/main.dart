import "package:flutter/material.dart";
import 'package:sevenc_iteration_two/testingNavigation.dart';
//import 'package:sevenc_iteration_two/userProfile/profile.dart';
import 'package:postgres/postgres.dart';

import './login/login.dart';
import './join/join.dart';
import './home/home.dart';
import './Themes.dart'; // Import the custom themes



void main() {

  // connecting to Virtual Machine
  // final database_connection = Connection.open();

  runApp(
      MaterialApp(
        // Set the app's theme
          theme: const MaterialTheme(TextTheme()).light(), // Apply the light theme
          darkTheme: const MaterialTheme(TextTheme()).dark(), // Apply the dark theme
          themeMode: ThemeMode.dark, // Choose the theme mode (Change .dark with .light if needed)

        // setting up initial routes to different screens, loading up login first
          initialRoute: "/home",
        // replace the "/navigation" with the page you are testing if you dont want to go through navigation
          routes: {
            "/home": (context) => const Home(),
            "/navigation": (context) => const NavigationPage(),
            "/login": (context) => const LoginScreen(),
            "/join": (context) => const JoinProject(),
            // "/userProfile/profile": (context) => const UserProfile(),

          }
      )
  );
}
