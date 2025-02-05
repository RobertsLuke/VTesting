import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // have to get the project name of the project the user is currently inside
  String screenTitle = "PROJECT_NAME";

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
    return Container(
      child: const Text("in here"),
    );
  }

  // creates the body of the add task tab
  Widget createAddTaskBody() {
    final TextEditingController taskTitleController = TextEditingController();
    final TextEditingController taskDescriptionController = TextEditingController();
    final TextEditingController subtaskController = TextEditingController();
    final TextEditingController percentageWeightingController = TextEditingController();
    final TextEditingController tagController = TextEditingController();
    final List<String> subtasks = [];
    final List<String> tags = [];
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    DateTime? dueDate;

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

    Future<void> pickDueDate() async {
      DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );
      if (selectedDate != null) {
        setState(() {
          dueDate = selectedDate;
        });
      }
    }

    void clearForm() {
      setState(() {
        taskTitleController.clear();
        taskDescriptionController.clear();
        subtaskController.clear();
        tagController.clear();
        percentageWeightingController.clear();
        subtasks.clear();
        tags.clear();
        dueDate = null;
      });
    }

    void createTask() {
      if (formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Task '${taskTitleController.text}' created successfully!")),
        );
      }
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
                  Text("Title",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blue[800],
                      )),
                  TextFormField(
                    controller: taskTitleController,
                    decoration: InputDecoration(
                      hintText: "Enter task title",
                      hintStyle: TextStyle(color: theme.colorScheme.onSurface.withAlpha(153)),
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: TextStyle(color: theme.colorScheme.onSurface),
                    validator: (value) => value!.isEmpty ? "Title cannot be empty" : null,
                  ),
                  const SizedBox(height: 16),

                  Text("Subtasks",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blue[800],
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: subtaskController,
                          decoration: InputDecoration(
                            hintText: "Add a subtask",
                            hintStyle: TextStyle(color: theme.colorScheme.onSurface.withAlpha(153)),
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

                  Text("Description",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blue[800],
                      )),
                  TextFormField(
                    controller: taskDescriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Enter task description",
                      hintStyle: TextStyle(color: theme.colorScheme.onSurface.withAlpha(153)),
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: TextStyle(color: theme.colorScheme.onSurface),
                    validator: (value) => value!.isEmpty ? "Description cannot be empty" : null,
                  ),
                  const SizedBox(height: 16),

                  Text("Priority Level",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blue[800],
                      )),
                  DropdownButtonFormField<int>(
                    items: [1, 2, 3, 4, 5]
                        .map((level) => DropdownMenuItem(
                      value: level,
                      child: Text("Priority $level",
                          style: TextStyle(color: theme.colorScheme.onSurface)),
                    ))
                        .toList(),
                    onChanged: (value) {},
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

                  Text("Due Date",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blue[800],
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          dueDate == null
                              ? "No date selected"
                              : "${dueDate!.day}/${dueDate!.month}/${dueDate!.year}",
                          style: TextStyle(color: theme.colorScheme.onSurface),
                        ),
                      ),
                      TextButton(
                        onPressed: pickDueDate,
                        child: Text("Pick Date", style: TextStyle(color: theme.colorScheme.primary)),
                      ),
                    ],
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
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blue[800],
                      )),
                  TextFormField(
                    controller: percentageWeightingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter percentage",
                      hintStyle: TextStyle(color: theme.colorScheme.onSurface.withAlpha(153)),
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: TextStyle(color: theme.colorScheme.onSurface),
                  ),
                  const SizedBox(height: 16),

                  Text("Tags",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blue[800],
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: tagController,
                          decoration: InputDecoration(
                            hintText: "Add a tag",
                            hintStyle: TextStyle(color: theme.colorScheme.onSurface.withAlpha(153)),
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

                  Text("File Drop",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blue[800],
                      )),
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
                          backgroundColor: Colors.red[700],
                        ),
                        child: const Text("Clear",
                            style: TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: createTask,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text("Create",
                            style: TextStyle(color: Colors.black)),
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
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          // the title of the bar will update depending on what column you have
          // currently selected
          title: Text(screenTitle),
          // the bottom will be the list of columns you can switch between to
          // switch tabs
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: "Home"),
              Tab(text: "Tasks"),
              Tab(
                text: "Add Tasks",
              ),
              Tab(text: "Messages"),
              Tab(text: "Files"),
              Tab(text: "Meetings"),
              Tab(text: "Contribution Report")
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
          createContributionReportBody()
        ]),
      ),
    );
  }
}
