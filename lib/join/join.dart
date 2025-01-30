import 'package:flutter/material.dart';

class JoinProject extends StatefulWidget {
  const JoinProject({super.key});

  @override
  State<JoinProject> createState() => _JoinProjectState();
}

class _JoinProjectState extends State<JoinProject> {

  // creating controllers so you can retrieve the text value from the input fields
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  // creating a function that returns a Input Box
  TextField createInputField(TextEditingController controller, String hintMessage) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintMessage
      ),
    );
  }


  // this function will be called when the user taps the submit button
  void submitAction() {
    print(idController.text);
    print(passwordController.text);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Join Group"),
          const Text("Group Name"),
          /*
          TextField(
            controller: idController,
              decoration: const InputDecoration(
                hintText: "Enter Group ID"
              ),
          ),
           */
          createInputField(idController, "Enter Group ID"),
          const Text("Group Password"),
          createInputField(passwordController, "Enter Group Password"),
          ElevatedButton(
              onPressed: submitAction,
              child: const Text("Submit"))
        ],
      ),
    );
  }
}
