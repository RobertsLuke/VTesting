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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text("Join Group"),
            const Text("Group Name"),
            // change the max input length to match specification in user requirements
            createInputField(idController, "Enter Group ID", 10, idInputValidator),
            const Text("Group Password"),
            createInputField(passwordController, "Enter Group Password", 10, passwordInputValidator),
            ElevatedButton(
                onPressed: submitAction,
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
