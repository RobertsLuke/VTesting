import "package:flutter/material.dart";
import './login/login.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: "/login",
      routes: {
        "/login": (context) => const LoginScreen()
      }
    )
  );
}