import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'components/components.dart';
import 'components/compact/compact_components.dart';
import 'components/add_task_screen.dart';
import 'components/list_of_tasks.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  String screenTitle = "Team 7C"; // User name 
  
  

  @override
  void initState() {
    super.initState();
    
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

  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Only 3 tabs now
      initialIndex: 0,
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
            tabs: <Widget>[
              Tab(text: "Home"),
              Tab(text: "Project Tasks"),
              Tab(text: "Add Task"), // Using singular form as in original home.dart
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          createHomeBody(),
          createTaskBody(),
          const AddTaskScreen()
        ]),
      ),
    );
  }
}
