// lib/home/components/kanban_board/kanban_board.dart
import 'package:flutter/material.dart';
import 'kanban_column.dart';

class KanbanBoard extends StatelessWidget {
  const KanbanBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Expanded(child: KanbanColumn(title: "To Do", status: "todo")),
        SizedBox(width: 16),
        Expanded(
            child: KanbanColumn(title: "In Progress", status: "in_progress")),
        SizedBox(width: 16),
        Expanded(child: KanbanColumn(title: "Completed", status: "completed")),
      ],
    );
  }
}
