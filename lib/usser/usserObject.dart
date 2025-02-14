import 'package:http/http.dart' as http;
import 'package:sevenc_iteration_two/usser/usserProfilePage.dart';

class Usser {
  late String usserID;
  String usserName;
  String email;
  String usserPassword;
  String theme;
  String profilePic;
  double currancyTotal;
  Map<String, dynamic> settings;
  Map<int, String> usserData = {};
  List<task> tasks = [];

  Usser({
    required this.usserName,
    required this.email,
    required this.usserPassword,
    required this.theme,
    required this.profilePic,
    required this.currancyTotal,
    required this.settings,
    this.tasks = const [],
  }) {
    uploadUsser();
    usserID = getID();
  }

  factory Usser.fromJson(Map<String, dynamic> json) {
    Usser usser = Usser(
      usserName: json['usserName'],
      email: json['email'],
      usserPassword: json['usserPassword'],
      theme: json['theme'],
      profilePic: json['profilePic'],
      currancyTotal: (json['currancyTotal'] as num).toDouble(),
      settings: json['settings'] ?? {},
    );
    usser.usserID = json['usserID'] ?? usser.getID();
    usser.usserData = (json['usserData'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(int.parse(key), value as String)) ?? {};
    return usser;
  }

  Map<String, dynamic> toJson() {
    return {
      'usserID': usserID,
      'usserName': usserName,
      'email': email,
      'usserPassword': usserPassword,
      'theme': theme,
      'profilePic': profilePic,
      'currancyTotal': currancyTotal,
      'settings': settings,
      'usserData': usserData.map((key, value) => MapEntry(key.toString(), value)),
    };
  }

  // gets the user id based on the user's email and username
  Future<dynamic> getID() async {
    // this function will upload the usser object to the database

    final Uri request = Uri.parse("http://127.0.0.1:5000/get/user/id?username=$usserName&email=$email");

    // set to dynamic since it may not return an integer if there is no id
    dynamic id;

    try {
      // using http to asynchronously get the information from flask
      final response = await http.get(request);

      if (response.statusCode == 200 ) {
        // if the response was successful you will get the expected information
        print(response.body);
        id = response.body;
      }
      else {
        // if you do not get a valid status code you will be returned an invalid
        // status code
        print(response.statusCode);
      }
    }
    catch (e) {
      // catching any exceptions
      print(e);
    }

    return id;
  }

  Future<void> uploadUsser() async{
    // this function will upload the usser object to the database

    final Uri request = Uri.parse("http://127.0.0.1:5000/create/profile?username=$usserName&email=$email");

    try {
      // using http to asynchronously get the information from flask
      final response = await http.get(request);

      if (response.statusCode == 200 ) {
        // if the response was successful you will get the expected information
        print(response.body);
      }
      else {
        // if you do not get a valid status code you will be returned an invalid
        // status code
        print(response.statusCode);
      }
    }
    catch (e) {
      // catching any exceptions
      print(e);
    }

  }

  void updateUsser(){
    // this function will update the usser object in the database

    // COME BACK TO THIS LATER
  }

  Future<String> getProjects() async{
    // this function will get the projects that the usser is a part of
    // THIS FUNCTION IS A WORK IN PROGRESS SO THERE MAY BE UNEXPECTED BEHAVIOUR

    dynamic id = getID();

    final Uri request = Uri.parse("http://127.0.0.1:5000/get/user/projects?user_id=$id");

    String projects = '';

    try {
      // using http to asynchronously get the information from flask
      final response = await http.get(request);

      if (response.statusCode == 200 ) {
        // if the response was successful you will get the expected information
        print(response.body);
        projects = response.body;
      }
      else {
        // if you do not get a valid status code you will be returned an invalid
        // status code
        print(response.statusCode);
      }
    }
    catch (e) {
      // catching any exceptions
      print(e);
    }

    return projects;
  }

  Future<List<task>> getTasksAsync() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return tasks; // Return stored tasks
  }
}


class task {
  // placholder to be replaced
  final String? name;
  final String? description;
  final String? dueDate;
  task({this.name, this.description, this.dueDate});
}


Usser mockUsser = Usser(
    usserName: "John Doe",
    email: "john@example.com",
    usserPassword: "password123",
    theme: "dark",
    profilePic: "https://example.com/profile.jpg",
    currancyTotal: 100.0,
    settings: {},
    tasks: [
      task(name: "Task 1"),
      task(name: "Task 2"),
      task(name: "Task 3"),
      task(name: "Task 1"),
      task(name: "Task 2"),
      task(name: "Task 3"),
      task(name: "Task 1"),
      task(name: "Task 2"),
      task(name: "Task 3"),
    ]
);