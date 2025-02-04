import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // have to get the project name of the project the user is currently inside
  String screenTitle = "PROJECT_NAME";

  Widget createProjectTimerCountdown() {

    // make this an updated countdown till the project finishes
    return const Text("PLACEHOLDER");
  }

  Widget createHomeBody() {

    return Container(
      child: Column(
        children: [
          Row(children: [
            Column(
              children: [
                const Text("Project Deadline"),
                createProjectTimerCountdown()
              ],
            )
          ],),
        ],
      ),
    );

  }

  // creates the body of the create task tab
  Widget createTaskBody() {
