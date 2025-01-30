import "package:flutter/material.dart";
import './login/login.dart';
import './join/join.dart';

void main() {
  runApp(
    MaterialApp(
      // setting up initial routes to different screens, loading up login first
      initialRoute: "/login",
      routes: {
        "/login": (context) => const LoginScreen(),
        "/join": (context) => const JoinProject()
      }
    )
  );
}