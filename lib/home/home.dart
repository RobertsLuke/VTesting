import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_page.dart';
import '../providers/tasks_provider.dart';
import '../Objects/task.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController controller;
  final Function(DateTime) onDateSelected;
  const DatePickerField({
    Key? key,
    required this.controller,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: "Pick a due date",
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: _pickEndDate,
        ),
      ),
    );
  }

  void _pickEndDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      // Pass the selected date to the parent widget using the callback
      widget.onDateSelected(selectedDate);
      // Update the controller's text with the selected date without triggering full rebuild
      widget.controller.text =
          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    }
  }
}


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // have to get the project name of the project the user is currently inside
  String screenTitle = "PROJECT_NAME";
  DateTime? endDate;
  List<Task> tasks = []; // List to store created tasks
  final TextEditingController endDateController = TextEditingController();

  
  Widget createProjectTimerCountdown() {
    // make this an updated countdown till the project finishes
    return const Text("PLACEHOLDER");
  }

  Widget createHomeBody() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  const Text("Project Deadline"),
                  createProjectTimerCountdown()
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  // creates the body of the create task tab
  Widget createTaskBody() {
    return Consumer<TaskProvider>(
    builder: (context, taskProvider, child) {
      return ListView.builder(
        itemCount: taskProvider.tasks.length,
        itemBuilder: (context, index) {
          final task = taskProvider.tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text("Priority: ${task.priority} | Due: ${task.endDate?.toLocal()}"),
          );
        },
      );
    },
  );
}

  // creates the body of the add task tab
  Widget createAddTaskBody() {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController percentageWeightingController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController subtaskController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();


  List<String> tags = [];
  DateTime? endDate;
  NotificationFrequency notificationFrequency = NotificationFrequency.daily;
  bool notificationPreference = true;
  List<String> subtasks = [];

  // Focus nodes for each field to track when the user moves to the next field
  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode subtaskFocusNode = FocusNode();
  FocusNode tagFocusNode = FocusNode();
  FocusNode percentageFocusNode = FocusNode();
  FocusNode priorityFocusNode = FocusNode();

  // Fields to store valid values
  String taskTitle = '';
  String taskDescription = '';
  double percentageWeighting = 0.0;
  int priorityLevel = 1;

  void addSubtask() {
    if (subtaskController.text.isNotEmpty) {
      setState(() {
        subtasks.add(subtaskController.text);
      });
      subtaskController.clear();
    }
  }

  void addTag() {
    if (tagController.text.isNotEmpty) {
      setState(() {
        tags.add(tagController.text);
      });
      tagController.clear();
    }
  }

 /* void pickEndDate() async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: endDate ?? DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365)),
  );

  if (selectedDate != null) {
    setState(() {
      // Updating the endDate state variable
      endDate = selectedDate;
    });

    // Update the text controller after the state has been updated
    endDateController.text =
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
  }
}*/




  void clearForm() {
    setState(() {
      titleController.clear();
      descriptionController.clear();
      subtaskController.clear();
      tagController.clear();
      percentageWeightingController.clear();
      subtasks.clear();
      tags.clear();
      endDate = null;
    });
  }

 void submitTask(DateTime? selectedEndDate) {
  if (selectedEndDate == null) {
    print("Error: endDate is NULL!");
    return;
  }

  Task newTask = Task(
    title: taskTitle,
    percentageWeighting: percentageWeighting,
    listOfTags: tags,
    priority: priorityLevel,
    endDate: selectedEndDate, // Use the parameter
    description: taskDescription,
    members: {},
    notificationPreference: notificationPreference,
    notificationFrequency: notificationFrequency,
    directoryPath: "path/to/directory",
  );

  Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
  print("Task created with endDate: ${newTask.endDate}");
}


  final theme = Theme.of(context);

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
      key: formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title", style: theme.textTheme.titleMedium),
                TextFormField(
                  controller: titleController,
                  focusNode: titleFocusNode,
                  decoration: InputDecoration(
                    hintText: "Enter task title",
                    filled: true,
                    fillColor: theme.colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  style: TextStyle(color: theme.colorScheme.onSurface),
                  validator: (value) => value!.isEmpty ? "Title cannot be empty" : null,
                  onChanged: (value) {
                    taskTitle = value;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(descriptionFocusNode);
                  },
                ),
                const SizedBox(height: 16),

                Text("Subtasks", style: theme.textTheme.titleMedium),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: subtaskController,
                        decoration: InputDecoration(
                          hintText: "Add a subtask",
                          filled: true,
                          fillColor: theme.colorScheme.surface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: theme.colorScheme.primary),
                      onPressed: addSubtask,
                    ),
                  ],
                ),
                Wrap(
                  children: subtasks
                      .map((subtask) => Chip(
                            label: Text(subtask,
                                style: TextStyle(color: theme.colorScheme.onPrimary)),
                            backgroundColor: theme.colorScheme.primary,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),

                Text("Description", style: theme.textTheme.titleMedium),
                TextFormField(
                  controller: descriptionController,
                  focusNode: descriptionFocusNode,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Enter task description",
                    filled: true,
                    fillColor: theme.colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  style: TextStyle(color: theme.colorScheme.onSurface),
                  validator: (value) => value!.isEmpty ? "Description cannot be empty" : null,
                  onChanged: (value) {
                    taskDescription = value;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(priorityFocusNode);
                  },
                ),
                const SizedBox(height: 16),

                Text("Priority Level", style: theme.textTheme.titleMedium),
                DropdownButtonFormField<int>(
                  items: [1, 2, 3, 4, 5]
                      .map((level) => DropdownMenuItem(
                            value: level,
                            child: Text("Priority $level",
                                style: TextStyle(color: theme.colorScheme.onSurface)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    priorityLevel = value ?? 1;
                  },
                  decoration: InputDecoration(
                    hintText: "Select priority",
                    filled: true,
                    fillColor: theme.colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              DatePickerField(
                controller: endDateController,
                onDateSelected: (selectedDate) {                  
                    endDate = selectedDate;                  
                },
              ),
                
        ],
            ),
          ),

          const SizedBox(width: 32), // Spacing between columns

          // Right Column
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Percentage Weighting", style: theme.textTheme.titleMedium),
                TextFormField(
                  controller: percentageWeightingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter percentage",
                    filled: true,
                    fillColor: theme.colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  style: TextStyle(color: theme.colorScheme.onSurface),
                  onChanged: (value) {
                    percentageWeighting = double.tryParse(value) ?? 0.0;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(tagFocusNode);
                  },
                ),
                const SizedBox(height: 16),

                Text("Tags", style: theme.textTheme.titleMedium),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: tagController,
                        focusNode: tagFocusNode,
                        decoration: InputDecoration(
                          hintText: "Add a tag",
                          filled: true,
                          fillColor: theme.colorScheme.surface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: theme.colorScheme.primary),
                      onPressed: addTag,
                    ),
                  ],
                ),
                Wrap(
                  children: tags
                      .map((tag) => Chip(
                            label: Text(tag,
                                style: TextStyle(color: theme.colorScheme.onPrimary)),
                            backgroundColor: theme.colorScheme.primary,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),

                Text("File Drop", style: theme.textTheme.titleMedium),
                Container(
                  height: 100,
                  width: double.infinity,
                  color: theme.colorScheme.surface,
                  child: Center(
                    child: Text(
                      "Drop files here (Doesn't have any functionality yet)",
                      style: TextStyle(color: theme.colorScheme.onSurface),
                    ),
                  ),
                ),
                const Spacer(),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: clearForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                      ),
                      child: Text("Clear",
                          style: TextStyle(color: theme.colorScheme.onPrimary)),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        print("Submit button pressed! endDate: $endDate, title:$taskTitle, description: $taskDescription, priority: $priorityLevel, tags: $tags, weight: $percentageWeighting");
                        submitTask(endDate);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                      ),
                      child: Text("Create",
                          style: TextStyle(color: theme.colorScheme.onPrimary)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


  // creates the body of the messages tab
  Widget createMessages() {
    return Container();
  }

  // creates the body of the create files tab
  Widget createFiles() {
    return Container();
  }

  // creates the body of the contribution report tab
  Widget createContributionReportBody() {
    return Container();
  }

  // creates the body of the meeting tab
  Widget createMeetings() {
    return Container();
  }

  
  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 7,
      initialIndex: 1,
      child: Scaffold(
        
        appBar: AppBar(
          // the title of the bar will update depending on what column you have
          // currently selected
          title: Text(screenTitle),
          // the bottom will be the list of columns you can switch between to
          // switch tabs
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: "Home"),
              Tab(text: "Tasks"),
              Tab(text: "Add Tasks"),
              Tab(text: "Messages"),
              Tab(text: "Files"),
              Tab(text: "Meetings"),
              Tab(text: "Contribution Report"),
            ],
          ),
        ),
        // The body will store the different contents of the screens
        body: TabBarView(children: <Widget>[
          createHomeBody(),
          createTaskBody(),
          createAddTaskBody(),
          createMessages(),
          createFiles(),
          createMeetings(),
          createContributionReportBody(),          
        ]),
      ),
    );
  }
}
