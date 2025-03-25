// lib/home/home.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'settings_page.dart';
import '../providers/tasks_provider.dart';
import '../Objects/task.dart';
import 'components/components.dart';
import 'components/compact/compact_components.dart';

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
      widget.onDateSelected(selectedDate);
      widget.controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Layout variables from home_screen.dart
  String screenTitle = "Team 7C";

  // Task functionality variables from original home.dart
  List<Task> tasks = [];
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController percentageWeightingController =
      TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> tags = [];
  NotificationFrequency notificationFrequency = NotificationFrequency.daily;
  bool notificationPreference = true;
  // Focus Nodes
  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode tagFocusNode = FocusNode();
  FocusNode percentageFocusNode = FocusNode();
  FocusNode priorityFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    titleFocusNode.addListener(() => _validateField(titleFocusNode, formKey));
    descriptionFocusNode
        .addListener(() => _validateField(descriptionFocusNode, formKey));
  }

  @override
  void dispose() {
    titleFocusNode
        .removeListener(() => _validateField(titleFocusNode, formKey));
    titleFocusNode.dispose();
    descriptionFocusNode
        .removeListener(() => _validateField(descriptionFocusNode, formKey));
    descriptionFocusNode.dispose();
    tagFocusNode.dispose();
    percentageFocusNode.dispose();
    priorityFocusNode.dispose();
    endDateController.dispose();
    tagController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    percentageWeightingController.dispose();
    priorityController.dispose();
    super.dispose();
  }

  // Validate input method from original home.dart
  void _validateField(FocusNode focusNode, GlobalKey<FormState> formKey) {
    if (!focusNode.hasFocus) {
      if (formKey.currentState != null) {
        formKey.currentState?.validate();
      }
    }
  }

  // Updated Home Body layout from home_screen.dart
  Widget createHomeBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Top row with three equal columns
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Projects List - Compact Version
                Expanded(
                  child: CompactProjectList(),
                ),
                const SizedBox(width: 16),
                // Groups List - Compact Version
                Expanded(
                  child: CompactGroupsList(),
                ),
                const SizedBox(width: 16),
                // Activity Tracker - Compact Version
                Expanded(
                  child: CompactActivityTracker(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Middle row with Kanban
          Expanded(
            flex: 3,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 1500),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "My Tasks",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Expanded(
                        child: KanbanBoard(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Bottom row with deadline manager
          Expanded(
            flex: 2,
            child: const DeadlineManager(),
          ),
        ],
      ),
    );
  }

  // Original task body from home.dart
  Widget createTaskBody() {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return ListView.builder(
          itemCount: taskProvider.tasks.length,
          itemBuilder: (context, index) {
            final task = taskProvider.tasks[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ExpansionTile(
                title: Text(task.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                    "Priority: ${task.priority} | Due: ${DateFormat('yyyy-MM-dd').format(task.endDate)}"),
                children: [
                  ListTile(
                    title: const Text("Parent Project"),
                    subtitle: Text(task.parentProject ?? "N/A"),
                  ),
                  ListTile(
                    title: const Text("Percentage Weighting"),
                    subtitle: Text("${task.percentageWeighting}%"),
                  ),
                  ListTile(
                    title: const Text("Tags"),
                    subtitle:
                        task.listOfTags != null && task.listOfTags!.isNotEmpty
                            ? Wrap(
                                spacing: 8,
                                children: task.listOfTags!
                                    .map((tag) => Chip(label: Text(tag)))
                                    .toList(),
                              )
                            : const Text("None"),
                  ),
                  ListTile(
                    title: const Text("Start Date"),
                    subtitle:
                        Text(DateFormat('yyyy-MM-dd').format(task.startDate)),
                  ),
                  ListTile(
                    title: const Text("Members"),
                    subtitle: Text(
                        task.members != null && task.members!.isNotEmpty
                            ? task.members!.entries
                                .map((e) => "${e.key}: ${e.value}")
                                .join(", ")
                            : "None"),
                  ),
                  ListTile(
                    title: const Text("Notification Preference"),
                    subtitle: Text(
                        task.notificationPreference ? "Enabled" : "Disabled"),
                  ),
                  ListTile(
                    title: const Text("Notification Frequency"),
                    subtitle: Text(
                        task.notificationFrequency.toString().split('.').last),
                  ),
                  ListTile(
                    title: const Text("Description"),
                    subtitle: Text(task.description),
                  ),
                  ListTile(
                    title: const Text("Directory Path"),
                    subtitle: Text(task.directoryPath),
                  ),
                  ListTile(
                    title: const Text("Comments"),
                    subtitle: Text(task.comments?.join("\n") ?? "No comments"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Task form methods from original home.dart
  void addTag() {
    formKey.currentState!.validate();
  }

  void clearForm() {
    setState(() {
      titleController.clear();
      descriptionController.clear();
      tagController.clear();
      percentageWeightingController.clear();
      priorityController.clear();
      endDateController.clear();
      tags = [];
    });
  }

  void submitTask() {
    if (formKey.currentState!.validate()) {
      Task newTask = Task(
        title: titleController.text,
        percentageWeighting:
            double.tryParse(percentageWeightingController.text) ?? 0.0,
        listOfTags: tags,
        priority: int.tryParse(priorityController.text) ?? 1,
        startDate: DateTime(2024, 9, 7, 12, 00),
        endDate: DateTime.parse(endDateController.text),
        description: descriptionController.text,
        members: const {},
        notificationPreference: notificationPreference,
        notificationFrequency: notificationFrequency,
        directoryPath: "path/to/directory",
      );

      Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
      clearForm();
    }
  }

  // Original add task body from home.dart
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
                        return "Title cannot be empty";
                      } else if (value.length > 50) {
                        return "Title cannot exceed 50 characters";
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(descriptionFocusNode);
                    },
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
                    validator: (value) => value == null || value.trim().isEmpty
                        ? "Description cannot be empty"
                        : null,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(priorityFocusNode);
                    },
                  ),
                  const SizedBox(height: 16),
                  Text("Priority Level", style: theme.textTheme.titleMedium),
                  DropdownButtonFormField(
                    items: ["1", "2", "3", "4", "5"]
                        .map((level) => DropdownMenuItem(
                              value: level,
                              child: Text("Priority $level",
                                  style: TextStyle(
                                      color: theme.colorScheme.onSurface)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      priorityController.text = value ?? "1";
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
                    onDateSelected: (selectedDate) {},
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
                  Text("Task's Weight", style: theme.textTheme.titleMedium),
                  TextFormField(
                    controller: percentageWeightingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Weighting Percentage (1-100)",
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: TextStyle(color: theme.colorScheme.onSurface),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Percentage cannot be empty";
                      }
                      final percentage = int.tryParse(value);
                      if (percentage == null ||
                          percentage < 1 ||
                          percentage > 100) {
                        return "Enter a value between 1 and 100";
                      }
                      return null;
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
                          submitTask();
                          tags = [];
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
      length: 3, // Only 3 tabs now
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.grey[850],
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
            tabs: <Widget>[
              Tab(text: "Home"),
              Tab(text: "Tasks"),
              Tab(
                  text:
                      "Add Task"), // Using singular form as in original home.dart
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          createHomeBody(),
          createTaskBody(),
          createAddTaskBody(),
        ]),
      ),
    );
  }
}
