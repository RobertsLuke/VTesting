import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

    // validates the email input box
    String? emailInputValidator(String value) {
      if (value.isEmpty) {
        return "Can not leave this field empty";
      }
      return null;
    }

    // validates the password input box
    String? passwordInputValidator(String value) {
      if (value.isEmpty) {
        return "Can not leave this field empty";
      }
      return null;
    }

    // validates the username input box
    String? usernameInputValidator(String value) {
      if (value.isEmpty) {
        return "Can not leave this field empty";
      }
      return null;
    }

    // creating a function that returns a Input Box
    TextFormField createInputField(TextEditingController controller, String hintMessage, int maxInputLength, Function validatorFunction) {
      return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintMessage,
        ),
        maxLength: maxInputLength,
        validator: (value) {
          return validatorFunction(value);
        },
        style: const TextStyle(color: Colors.white70),
      );
    }

    void submitAction() {
      if (_formKey.currentState!.validate()) {}

    }
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Row(
        children: [
          // first half of the login screen DECORATION
          SizedBox(
            height: height,
            width: width * 0.5,
            child: Container(
              color: Colors.blue[800],
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(mode, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue[800]),),
                  const SizedBox(height: 70),
                  Text("Username", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey[300])),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: 200,
                    child: createInputField(username, "Enter your username", 10, emailInputValidator)
                  ),
                  const SizedBox(height: 50),
                  Text("Password", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey[300])),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: 200,
                    child: createInputField(password, "Enter Password", 10, passwordInputValidator)
                  ),
                  const SizedBox(height: 50),
                  // confirm button
                  ElevatedButton(
                      onPressed: submitAction,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
                      child: const Text("confirm", style: TextStyle(color: Colors.white))),
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
            ),
          )
        ],
      ),
    );
  }
}