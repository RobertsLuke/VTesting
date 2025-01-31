import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoginMode = true;

  final _username = TextEditingController();
  final _password = TextEditingController();
  final _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

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

    void changePageState() {
      setState(() {
        isLoginMode = !isLoginMode;
      });
    }

    // this handles the ui for the username
    Container usernameContainer() {
      return Container(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Text("Username", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey[300])),
            SizedBox(
                width: 200,
                child: createInputField(_username, "Enter your username", 10, usernameInputValidator)
            ),

          ],
        ),
      );
    }

    // this handles the ui for the email
    Container emailContainer() {
      return Container(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Text("Email", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey[300])),
            SizedBox(
                width: 200,
                child: createInputField(_email, "Enter your email", 10, emailInputValidator)
            ),
          ],
        ),
      );
    }

    Container passwordContainer() {
      return Container(
        child: Column(
          children: [
            Text("Password", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey[300])),
            const SizedBox(height: 50),
            SizedBox(
                width: 200,
                child: createInputField(_password, "Enter Password", 10, passwordInputValidator)
            ),
          ],
        ),
      );
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
                  const SizedBox(height: 20,),
                  Text("Welcome!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey[300])),
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
                  Text((isLoginMode)?"Login":"Sign Up" , style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue[800]),),
                  // const SizedBox(height: 70),
                  emailContainer(),
                  (isLoginMode)?  const SizedBox(height: 50) : usernameContainer(),
                  const SizedBox(height: 50),
                  passwordContainer(),
                  const SizedBox(height: 50),
                  // confirm button
                  ElevatedButton(
                      onPressed: submitAction,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
                      child: const Text("confirm", style: TextStyle(color: Colors.white))),
                  const SizedBox(height: 20,),
                  // switch mode button
                  GestureDetector(
                    onTap: () {
                      changePageState();
                    },
                    child: Text((isLoginMode)?"Want to Sign Up?":"Want to Login?", style: const TextStyle(color: Colors.white70)),
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