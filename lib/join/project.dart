import '../usser/usserObject.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class Project {
  String? projectUuid;
  String name;
  String joinCode;
  List<Usser> members;
  DateTime? dueDate;

  // if you are trying to create a group, then the dueDate will be passed as an
  // argument
  Project(this.name, this.joinCode, this.members, [this.dueDate]);

  Future<bool?> uuidExists(String tempUuid) async {
    // method to ensure that uuid isn't already associated to a project otherwise
    // have to regenerate a new uuid

    final Uri request = Uri.parse("http://127.0.0.1:5000/get/user/id?email=$tempUuid");

    try {
      // using http to asynchronously get the information from flask
      final response = await http.get(request);

      if (response.statusCode == 200) {
        // if the response was successful you will get the expected information
        print(response.body);
        if (int.parse(response.body) > 0) { return true; }
        else { return false; }
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

    // return null if there is an error
    return null;
  }

  void generateUuid() async{
    // method to generate the uuid, need to ensure that there isn't another
    // project which already uses this uuid

    Uuid uuid = const Uuid();

    bool? exists = true;

    // keep trying to generate new uuid till original one found
    while (exists == true) {
      String tempUuid = uuid.v6();

      // if the uuid doesn't exist inside the database, then you can store it
      // inside the database and move on

      exists = await uuidExists(tempUuid);
      if (exists == false) {
        projectUuid = tempUuid;
        // uploadUuid(tempUuid);
      }
      else if (exists == null) {
        // need to handle what happens if there is an error trying to check if
        // the uuid exists

        // ADD MORE HERE
        break;
      }
    }

  }

  /*
  Future<void> uploadUuid(String tempUuid) async {
    // once the uuid has been generated and it is unique, this method will handle
    // storing the uuid in the database

    final Uri request = Uri.parse(
        "http://127.0.0.1:5000/get/user/id?email=$tempUuid");

    try {
      // using http to asynchronously get the information from flask
      final response = await http.get(request);

      if (response.statusCode == 200) {
        // if the response was successful you will get the expected information
        print(response.body);
        print("IN STATUS CODE 200");
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
      print("IN EXCEPTION");
    }
  }

   */

  Future<void> uploadProjectDatabase() async {
    // this function will be responsible for uploading the project to the database
    final Uri request = Uri.parse(
        "http://127.0.0.1:5000/get/user/id?uuid=$projectUuid&name=$name&join=$joinCode&due=$dueDate");

    try {
      // using http to asynchronously get the information from flask
      final response = await http.get(request);

      if (response.statusCode == 200) {
        // if the response was successful you will get the expected information
        print(response.body);
        print("IN STATUS CODE 200");
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
      print("IN EXCEPTION");
    }
  }

  /*
  void getUuid() => projectUuid;
   */
}