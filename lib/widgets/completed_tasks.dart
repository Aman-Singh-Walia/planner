import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:planner/models/task.dart';
import 'package:planner/widgets/completed_task_tile.dart';
import 'package:planner/widgets/no_item.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Task>('usertasks').listenable(),
        builder: (context, box, _) {
          final b = Hive.box<Task>('usertasks');
          List<Task> doneTasksList =
              b.values.where((element) => element.completed).toList();
          return doneTasksList.isEmpty
              ? const NoItem(msg: 'No Completed Tasks')
              : ListView(
                  children: doneTasksList
                      .map((e) => CompletedTaskTile(task: e))
                      .toList(),
                );
        });
  }
}
