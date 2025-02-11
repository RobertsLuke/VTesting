import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:postgres/postgres.dart';
import 'providers/theme_provider.dart';
import './login/login.dart';
import './join/join.dart';
<<<<<<< HEAD
import 'home/home_screen.dart';
import './Themes.dart'; // Import the custom themes

void main() {
  // connecting to Virtual Machine
  // final database_connection = Connection.open();

  runApp(MaterialApp(
      // Set the app's theme
      theme: const MaterialTheme(TextTheme()).light(), // Apply the light theme
      darkTheme:
          const MaterialTheme(TextTheme()).dark(), // Apply the dark theme
      themeMode: ThemeMode
          .dark, // Choose the theme mode (Change .dark with .light if needed)

      // setting up initial routes to different screens, loading up login first
      initialRoute: "/home",
      // replace the "/navigation" with the page you are testing if you dont want to go through navigation
      routes: {
        "/home": (context) => const Home(),
        "/navigation": (context) => const NavigationPage(),
        "/login": (context) => const LoginScreen(),
        "/join": (context) => const JoinProject(),
        // "/userProfile/profile": (context) => const UserProfile(),
      }));
=======
import './home/home.dart';
import 'package:sevenc_iteration_two/testingNavigation.dart';
// import 'package:sevenc_iteration_two/userProfile/profile.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(), // Provide the theme provider
      child: const MyApp(),
    ),
  );
>>>>>>> 1234c98d3fa6e22a09b3ee6604922aa86a13935b
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      theme: themeProvider.currentTheme,  // Set theme based on provider
      initialRoute: "/home",
      routes: {
        "/home": (context) => const Home(),
        "/navigation": (context) => const NavigationPage(),
        "/login": (context) => const LoginScreen(),
        "/join": (context) => const JoinProject(),
      },
    );
  }
}
