import 'package:flutter/material.dart';
import 'validation.dart';
import 'input_field_containers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoginMode = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    void submitAction() {
      if (_formKey.currentState!.validate()) {}
    }

    void changePageState() {
      setState(() {
        isLoginMode = !isLoginMode;
      });
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