import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();

    // this is for prototyping only, in the iteration 2 we will switch to firebase
    List<Map<String, String>> userDetails = [
      {"name": "jib", "password": "admin1234"},
      {"name": "luke", "password": "DiwizMySecretSecret..."}];

    String mode = "Login";

    String getButtonText() {
      if (mode == "Login") {
        return "Switch to Sign Up";
      }
      return "Switch to Login";
    }

    // this function will be called when the user presses confirm on the login
    // screen
    void login(String username, String password) {

      bool exists = false;

      for (var user in userDetails) {
        if (user["name"] == username && user["password"] == password) {
          // successful, correct username and password
          //Navigator.pushNamed(context, '/createProject');
          print("successful");
          exists = !exists;
          break;
        }
        else if (user["name"] == username) {
          // user exists but incorrect password
          print("incorrect password");
          exists = !exists;
          break;
        }
      }

      if (!exists) {
        print("this user does not exist");
      }
    }

    // this function will be called when the user presses confirm on the sign up
    // screen

    void signUp(String username, String password) {
      bool exists = false;

      for (var user in userDetails) {
        if (user["name"] == username) {
          // username already exists so you can not signUp
          exists = !exists;
          break;
        }
      }

      if (exists) {
        print("username already exists, try creating a new username");
      }
      else {
        if (password.length < 8) {
          print("password is too short");
        }
        userDetails.add({"name": username, "password": password});
        print("added user to list");
      }
    }

    return Scaffold(
      body: Row(
        children: [
          // first half of the login screen DECORATION
          SizedBox(
            height: height,
            width: width * 0.5,
            child: Container(
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 200, width: 300 ,child: Image.asset("assets/login/welcome_image.jpg")),
                  const Text("Welcome!", style: TextStyle(color: Colors.white, fontSize: 30),),
                ],
              ),
            ),
          ),
          // second half of the login screen USER DETAILS
          SizedBox(
            height: height,
            width: width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(mode),
                const SizedBox(height: 40,),
                const Text("username"),
                const SizedBox(width: 10,),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: username,
                  ),
                ),
                const SizedBox(width: 20,),
                const Text("password"),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: password,
                  ),
                ),
                const SizedBox(height: 20,),
                // confirm button
                ElevatedButton(
                    onPressed: () {
                      if (mode == "Login") {
                        login(username.text, password.text);
                      }
                      else {
                        signUp(username.text, password.text);
                      }
                    },
                    child: Text("confirm")),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (mode == "Login") {
                        mode = "Sign Up";
                      }
                      else {
                        mode = "Login";
                      }
                    });
                  },
                  child: Text(getButtonText(), style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}