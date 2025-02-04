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
          Row(
            children: [
              Column(
                children: [
                  const Text("Project Deadline"),
                  createProjectTimerCountdown()
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  // creates the body of the create task tab
  Widget createTaskBody() {
    return Container(
      child: Text("in here"),
    );
  }

  // creates the body of the add task tab
  Widget createAddTaskBody() {
    return Container(
      child: Text("in here "),
    );
  }

  // creates the body of the messages tab
  Widget createMessages() {
    return Container();
  }

  // creates the body of the create files tab
  Widget createFiles() {
    return Container();
  }

  // creates the body of the contribution report tab
  Widget createContributionReportBody() {
    return Container();
  }

  // creates the body of the meeting tab
  Widget createMeetings() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          // the title of the bar will update depending on what column you have
          // currently selected
          title: Text(screenTitle),
          // the bottom will be the list of columns you can switch between to
          // switch tabs
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: "Home"),
              Tab(text: "Tasks"),
              Tab(
                text: "Add Tasks",
              ),
              Tab(text: "Messages"),
              Tab(text: "Files"),
              Tab(text: "Meetings"),
              Tab(text: "Contribution Report")
            ],
          ),
        ),
        // The body will store the different contents of the screens
        body: TabBarView(children: <Widget>[
          createHomeBody(),
          createTaskBody(),
          createAddTaskBody(),
          createMessages(),
          createFiles(),
          createMeetings(),
          createContributionReportBody()
        ]),
      ),
    );
  }
}
