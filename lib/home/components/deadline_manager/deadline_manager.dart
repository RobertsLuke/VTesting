// lib/home/components/deadline_manager/deadline_manager.dart
import 'package:flutter/material.dart';
import 'deadline_section.dart';

class DeadlineManager extends StatelessWidget {
  const DeadlineManager({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upcoming Deadlines",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // TODO: Implement calendar view
                  },
                  icon: Icon(Icons.calendar_today, color: colorScheme.primary),
                  label: Text(
                    "View Calendar",
                    style: TextStyle(color: colorScheme.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  DeadlineSection(title: "Today"),
                  SizedBox(height: 16),
                  DeadlineSection(title: "Tomorrow"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
