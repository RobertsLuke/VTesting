import "package:flutter/material.dart";
import 'package:sevenc_iteration_two/testingNavigation.dart';
// import 'package:sevenc_iteration_two/userProfile/profile.dart';

import './login/login.dart';
import './join/join.dart';


void main() {
  runApp(
      MaterialApp(
        // setting up initial routes to different screens, loading up login first
          initialRoute: "/login/login",
        // replace the "/navigation" with the page you are testing if you dont want to go through navigation
          routes: {
            "/navigation": (context) => const NavigationPage(),
            "/login/login": (context) => const LoginScreen(),
            "/join/join": (context) => const JoinProject(),
            //"/userProfile/profile": (context) => const UserProfile(),

          }
      )
  );
}
