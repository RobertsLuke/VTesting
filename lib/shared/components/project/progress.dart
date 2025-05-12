import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../container_template.dart';
import '../action_button.dart';
import '../../../providers/tasks_provider.dart';
import '../../../Objects/task.dart';

// displays project completion progress
// [shows visual progress bar and task completion stats]
class ProgressComponent extends StatelessWidget {
  final String? projectUuid;
  
  const ProgressComponent({super.key, this.projectUuid});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final tasks = Provider.of<TaskProvider>(context).tasks;
    
    // filter tasks for this specific project
    final projectTasks = projectUuid != null 
        ? tasks.where((task) => task.parentProject == projectUuid).toList()
        : tasks;
    
    // calculate progress percentages
    final totalTasks = projectTasks.length;
    final completedTasks = projectTasks.where((task) => task.status == Status.completed).length;
    final progressValue = totalTasks > 0 ? completedTasks / totalTasks : 0.0;
    final progressPercentage = (progressValue * 100).toInt();
    
    return ContainerTemplate(
      title: 'Progress',
      height: 250,
      child: Column(
        children: [
          // task completion section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Task Completion',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // percentage display
                  Text(
                    '$progressPercentage%',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // visual progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progressValue,
                  minHeight: 10,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // tasks count display
              Text(
                '$completedTasks/$totalTasks tasks complete',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // button to access detailed task view
          const Center(
            child: ActionButton(
              label: 'View Tasks',
              icon: Icons.list_alt,
            ),
          ),
        ],
      ),
    );
  }
}