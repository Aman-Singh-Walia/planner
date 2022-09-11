import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/models/task.dart';
import 'package:planner/pages/view_edit_task_page.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        task.delete();
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewEditTaskPage(task: task)));
      },
      leading: Text(
        task.sticker,
        style: const TextStyle(fontSize: 30.0),
      ),
      title: Text(
        task.content,
        maxLines: 1,
      ),
      subtitle: Row(
        children: [
          task.reminder
              ? const Icon(
                  Icons.notifications_active,
                  size: 15.0,
                  color: Colors.blue,
                )
              : const Icon(
                  Icons.notifications_off,
                  size: 15.0,
                ),
          Text(
            DateFormat(' dd-MM-yyyy  HH:mm').format(task.reminderDateTime),
            style: TextStyle(
                fontSize: 10.0, color: task.reminder ? Colors.blue : null),
          )
        ],
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
