import 'package:flutter/material.dart';
import '../usser/usserObject.dart';
import 'project.dart';
import 'package:provider/provider.dart';

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
  DateTime? selectedDueDate;

  // this variable dictates the state of the screen. When equal to true, it will
  // allow the user to join a group. When equal to false, it will allow the user
  // to create a group.
  bool joinMode = true;

  // this is going to be the DateTime value that the user sets inside of the calendar
  final dueDate = DateTime.now();

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

  Container dueDateContainer() {
    DateTime currentTime = DateTime.now();

    return Container(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Align(alignment: Alignment.centerLeft,child: Text("Due Date", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey[300])),),
            const SizedBox(height: 10),
            dueDateWidget(),
            const SizedBox(height: 20),
           ],
        )
    );
  }
  Widget dueDateWidget() {
    DateTime currentTime = DateTime.now();
    DateTime finalDateInCalendar = DateTime(currentTime.year + 5, currentTime.month, currentTime.day);

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: CalendarDatePicker(
          initialDate: currentTime,
          firstDate: currentTime,
          lastDate: finalDateInCalendar,
          onDateChanged: (selectedDate) {
            selectedDueDate = selectedDate;
          }
      ),
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
  void submitAction() async {

    // validate the form key. Will trigger the validator in the input field's TextFormField
    if (_formKey.currentState!.validate()) {
      // if form validates successfully, this block will execute

      // if you are trying to create a project
      if (!joinMode && selectedDueDate != null) {
          // if the selected due date on the calendar is not chosen, then the
          // user will NOT be able to create a group

          context.read<Project>().name = idController.text;
          context.read<Project>().joinCode = passwordController.text;
          context.read<Project>().members.add(context.read<Usser>());
          context.read<Project>().dueDate = selectedDueDate;

          /*
          Project project = Project(idController.text, passwordController.text, [],
              selectedDueDate);
           */

          await context.read<Project>().generateUuid();

          print(context.read<Project>().name);
          print(context.read<Project>().joinCode);
          print(context.read<Project>().members);
          print(context.read<Project>().dueDate);
          print(context.read<Project>().projectUuid);

          await context.read<Project>().uploadProjectDatabase();


      }
      else if (joinMode) {
        // trying to join a group

        context.read<Project>().name = idController.text;
        context.read<Project>().joinCode = passwordController.text;

        /*
        Project project = Project(idController.text, passwordController.text, []);
         */


      }

    }
    print(idController.text);
    print(passwordController.text);
  }

  // changes the screen state between join group and create group
  void changePageState() {
    setState(() {
      joinMode = !joinMode;
    });
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
              child: ListView(
                children: [Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text((joinMode)?"Join Group": "Create Group", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue[800]),),
                    const SizedBox(height: 100),
                    Align(alignment: Alignment.centerLeft,child: Text((joinMode)?"Group ID": "Group Name", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey[300])),),
                    // change the max input length to match specification in user requirements
                    createInputField(idController, (joinMode)?"Enter Group ID": "Enter Project Name", 10, idInputValidator),
                    const SizedBox(height: 100),
                    Align(alignment: Alignment.centerLeft, child: Text("Group Password", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey[300]))),
                    createInputField(passwordController, "Enter Group Password", 10, passwordInputValidator),
                    // const SizedBox(height: 100),
                    (joinMode)?  const SizedBox(height: 100): dueDateContainer(),
                    ElevatedButton(
                        onPressed: submitAction,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800]),
                        child: const Text("Submit", style: TextStyle(color: Colors.white),)
                    ),
                    const SizedBox(height: 50,),
                    GestureDetector(child: Text((joinMode)?"Want to create Project?": "Want to join a Project?", style: const TextStyle(color: Colors.white70),), onTap: () {changePageState();}),
                    const SizedBox(height: 10,)
                  ],
                ),
              ]
              ),
            ),
            SizedBox(width: width / 3,),
          ],
        ),
      ),
    );
  }
}
