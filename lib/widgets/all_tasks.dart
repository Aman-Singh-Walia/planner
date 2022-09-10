import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:planner/models/task.dart';
import 'package:planner/widgets/no_item.dart';
import 'package:planner/widgets/task_tile.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Task>('usertasks').listenable(),
        builder: (context, box, _) {
          final b = Hive.box<Task>('usertasks');
          List<Task> allTasksList =
              b.values.where((e) => !e.completed).toList();
          return allTasksList.isEmpty
              ? const NoItem(msg: 'No Tasks')
              : ListView(
                  children: allTasksList.map((e) => TaskTile(task: e)).toList(),
                );
        });
  }
}
