import 'package:flutter/material.dart';

class JoinProject extends StatefulWidget {
  const JoinProject({super.key});

  @override
  State<JoinProject> createState() => _JoinProjectState();
}

class _JoinProjectState extends State<JoinProject> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // creating controllers so you can retrieve the text value from the input fields
  final idController = TextEditingController();
  final passwordController = TextEditingController();

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

  // validator function for the group id input field to make sure it meets requirements
  String? idInputValidator(String value) {
    if (value.isEmpty) {
      return "Can not leave this field empty";
    }
    return null;
  }

  // validator function for the password input field to make sure it meets requriements
  String? passwordInputValidator(String value) {
    if (value.isEmpty) {
      return "Can not leave this field empty";
    }
    return null;
  }

  // this function will be called when the user taps the submit button
  void submitAction() {

    // validate the form key. Will trigger the validator in the input field's TextFormField
    if (_formKey.currentState!.validate()) {

    }
    print(idController.text);
    print(passwordController.text);
  }

  // changes the screen state between join group and create group
  void changePageState() {
    print("in here!");
  }

  @override
  Widget build(BuildContext context) {

    // getting the width of the screen
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Form(
        key: _formKey,
        child: Row(
          children: [
            SizedBox(width: width / 3,),
            SizedBox(
              width: width / 3,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text("Join Group", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue[800]),),
                  const SizedBox(height: 100),
                  Align(alignment: Alignment.centerLeft,child: Text("Group Name", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey[300])),),
                  // change the max input length to match specification in user requirements
                  createInputField(idController, "Enter Group ID", 10, idInputValidator),
                  const SizedBox(height: 100),
                  Align(alignment: Alignment.centerLeft, child: Text("Group Password", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey[300]))),
                  createInputField(passwordController, "Enter Group Password", 10, passwordInputValidator),
                  const SizedBox(height: 100),
                  ElevatedButton(
                      onPressed: submitAction,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[800]),
                      child: const Text("Submit", style: TextStyle(color: Colors.white),)
                  ),
                  const SizedBox(height: 50,),
                  GestureDetector(child: const Text("Want to create Project?"), onTap: () {changePageState();}),
                ],
              ),
            ),
            SizedBox(width: width / 3,),
          ],
        ),
      ),
    );
  }
}
