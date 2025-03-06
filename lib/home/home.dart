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
          icon: const Icon(Icons.calendar_today),
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
  // Application
  String screenTitle = "PROJECT_NAME";
  DateTime? endDate;
  List<Task> tasks = []; // List to store created tasks
  //Controllers
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController percentageWeightingController =
      TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController subtaskController = TextEditingController();
  //Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //Tags & Subtasks
  List<String> tags = [];
  List<String> subtasks = [];
  NotificationFrequency notificationFrequency = NotificationFrequency.daily;
  bool notificationPreference = true;
  // Focus Nodes
  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode subtaskFocusNode = FocusNode();
  FocusNode tagFocusNode = FocusNode();
  FocusNode percentageFocusNode = FocusNode();
  FocusNode priorityFocusNode = FocusNode();
  //Task Data
  //String taskTitle = '';
  //String taskDescription = '';
  //double percentageWeighting = 0.0;
  int priorityLevel = 1;

  @override
  void initState() {
    super.initState();
    titleFocusNode.addListener( () => _validateField(titleFocusNode, formKey)); // Add Listeners
    descriptionFocusNode.addListener( () => _validateField(descriptionFocusNode,formKey));
  }

  @override
  void dispose() {
    titleFocusNode.removeListener( () => _validateField(titleFocusNode, formKey)); // Remove Listeners - Focus Nodes
    titleFocusNode.dispose();
    descriptionFocusNode.removeListener( () => _validateField(descriptionFocusNode,formKey));
    descriptionFocusNode.dispose();
    subtaskFocusNode.dispose();
    tagFocusNode.dispose();
    percentageFocusNode.dispose();
    priorityFocusNode.dispose();
    endDateController.dispose();
    tagController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    percentageWeightingController.dispose();
    priorityController.dispose();
    subtaskController.dispose();

    super.dispose();
  }

// Validate input  
void _validateField(FocusNode focusNode, GlobalKey<FormState> formKey) {
  if (!focusNode.hasFocus) {
    if (formKey.currentState != null) {
      formKey.currentState?.validate();
    }
  }
}

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

  Widget createTaskBody() {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return ListView.builder(
          itemCount: taskProvider.tasks.length,
          itemBuilder: (context, index) {
            final task = taskProvider.tasks[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text(
                  "Priority: ${task.priority} | Due: ${task.endDate?.toLocal()}"),
            );
          },
        );
      },
    );
  }

  void addSubtask() {
    if (subtaskController.text.isNotEmpty) {
      setState(() {
        subtasks.add(subtaskController.text);
      });
      subtaskController.clear();
    }
  }

  void addTag() {
    formKey.currentState!.validate();
  }

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
      // Reset any form validation state
      formKey.currentState?.reset();
    });
  }

  void submitTask(DateTime? selectedEndDate) {
    if (formKey.currentState!.validate()) {
      // Form is valid, proceed with submission
      if (selectedEndDate == null) {
        print("Error: endDate is NULL!");
        return;
      }

      Task newTask = Task(
      title: titleController.text,
      percentageWeighting: double.tryParse(percentageWeightingController.text) ?? 0.0,
      listOfTags: tags,
      priority: 1,
      endDate: selectedEndDate, // Use the parameter
      description: descriptionController.text,
      members: const {},
      notificationPreference: notificationPreference,
      notificationFrequency: notificationFrequency,
      directoryPath: "path/to/directory",
    );
      Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
      print("Task created with endDate: ${newTask.endDate}");
      clearForm();
    } else {
      print("form is not valid");
    }
  }

  // creates the body of the add task tab
  Widget createAddTaskBody() {
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
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Title cannot be empty"; // empty input
                      } else if (value.length > 50) {
                        return "Title cannot exceed 50 characters"; // input exceeding limit 50 char
                      }
                      return null;
                    },
                    /*onChanged: (value) {
                      taskTitle = value;
                    },*/
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
                                  style: TextStyle(
                                      color: theme.colorScheme.onPrimary)),
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
                    validator: (value) =>
                        value == null || value.trim().isEmpty ? "Description cannot be empty" : null,
                   /*onChanged: (value) {
                      taskDescription = value;
                    },*/
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
                                  style: TextStyle(
                                      color: theme.colorScheme.onSurface)),
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
                  Text("Percentage Weighting",
                      style: theme.textTheme.titleMedium),
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
                    /*onChanged: (value) {
                      percentageWeighting = double.tryParse(value) ?? 0.0;
                    },*/
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
                        onPressed: () {
                          if (tagController.text.trim().isNotEmpty) {
                            setState(() {
                              tags.add(tagController.text.trim());
                            });
                            tagController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                  Wrap(
                    children: tags
                        .map((tag) => Chip(
                              label: Text(tag,
                                  style: TextStyle(
                                      color: theme.colorScheme.onPrimary)),
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
                            style:
                                TextStyle(color: theme.colorScheme.onPrimary)),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          submitTask(endDate);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.secondary,
                        ),
                        child: Text("Submit",
                            style: TextStyle(
                                color: theme.colorScheme.onSecondary)),
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(screenTitle),
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
            tabs: [
              Tab(text: "Home"),
              Tab(text: "Tasks"),
              Tab(text: "Add Task"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            createHomeBody(),
            createTaskBody(),
            createAddTaskBody(),
          ],
        ),
      ),
    );
  }
}
