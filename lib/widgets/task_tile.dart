import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/models/task.dart';
import 'package:planner/pages/view_edit_task_page.dart';
import 'package:planner/services/notification_api.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(15.0)),
        onLongPress: () async {
          if (task.reminder) {
            await NotificationApi.removeSchedules(task.scheduleId);
            task.delete();
          } else {
            task.delete();
          }
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
            Icon(
              task.reminder
                  ? Icons.notifications_active
                  : Icons.notifications_off,
              size: 15.0,
              color:
                  task.reminder && task.reminderDateTime.isAfter(DateTime.now())
                      ? Colors.blue
                      : task.reminder &&
                              task.reminderDateTime.isBefore(DateTime.now())
                          ? Colors.red
                          : null,
            ),
            Text(
              DateFormat(' dd-MM-yyyy  HH:mm').format(task.reminderDateTime),
              style: TextStyle(
                  fontSize: 10.0,
                  color: task.reminder &&
                          task.reminderDateTime.isAfter(DateTime.now())
                      ? Colors.blue
                      : task.reminder &&
                              task.reminderDateTime.isBefore(DateTime.now())
                          ? Colors.red
                          : null),
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
          onPressed: () async {
            if (task.reminder) {
              await NotificationApi.removeSchedules(task.scheduleId);
              task.completed = !task.completed;
              task.save();
            } else {
              task.completed = !task.completed;
              task.save();
            }
          },
        ),
      ),
    );
  }
}
