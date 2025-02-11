// import 'dart:convert';
import 'package:http/http.dart' as http;


Future<void> getRequest(String username, String email) async {
  final Uri request = Uri.parse("http://127.0.0.1:5000/check/user/exists?username=$username&email=$email");

  try {
    // using http to asynchronously get the information from flask
    final response = await http.get(request);
    
    if (response.statusCode  == 200) {
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


void main() {
  getRequest('test_user2', 'test2@gmail.com');
}