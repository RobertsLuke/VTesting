import "package:flutter/material.dart";
import 'package:sevenc_iteration_two/testingNavigation.dart';
//import 'package:sevenc_iteration_two/userProfile/profile.dart';
import 'package:postgres/postgres.dart';

import './login/login.dart';
import './join/join.dart';


void main() {

  // connecting to Virtual Machine
  // final database_connection = Connection.open();

  runApp(
      MaterialApp(
        // setting up initial routes to different screens, loading up login first
          initialRoute: "/join",
        // replace the "/navigation" with the page you are testing if you dont want to go through navigation
          routes: {
            "/navigation": (context) => const NavigationPage(),
            "/login": (context) => const LoginScreen(),
            "/join": (context) => const JoinProject(),
            // "/userProfile/profile": (context) => const UserProfile(),

          }
      )
  );
}
