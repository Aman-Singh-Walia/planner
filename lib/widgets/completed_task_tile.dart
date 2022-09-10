import 'package:planner/models/task.dart';
import 'package:flutter/material.dart';

class CompletedTaskTile extends StatelessWidget {
  final Task task;
  const CompletedTaskTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        task.delete();
      },
      onTap: () {},
      leading: Text(
        task.sticker,
        style: const TextStyle(fontSize: 30.0),
      ),
      title: Text(
        task.content,
        maxLines: 1,
      ),
      trailing: IconButton(
        icon: task.completed
            ? const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
              )
            : const Icon(Icons.circle_outlined),
        onPressed: () {
          task.completed = !task.completed;
          task.save();
        },
      ),
    );
  }
}
