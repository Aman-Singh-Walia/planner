import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:planner/models/task.dart';
import 'package:planner/services/notification_api.dart';
import 'package:planner/widgets/alert_dialog.dart';
import 'package:planner/widgets/date_time_picker.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController stickerController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  DateTime dateTime = DateTime.now();
  bool reminder = false;
  DateTime reminderDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text('Add Task'),
        actions: [
          IconButton(
              onPressed: () {
                int scheduleId = DateTime.now().month +
                    DateTime.now().day +
                    DateTime.now().millisecond;

                if (contentController.text.isEmpty) {
                  showAlertDialog(
                      context, 'Alert', 'Could not save empty task');
                  return;
                }
                if (stickerController.text.isEmpty) {
                  stickerController.text = '🌹';
                }
                if (reminder) {
                  if (reminderDateTime.isAfter(dateTime) ||
                      reminderDateTime.isBefore(DateTime.now())) {
                    showAlertDialog(context, 'Alert',
                        'Can not set reminder for the selected date and time');

                    return;
                  }
                  NotificationApi.showScheduledNotification(
                      id: scheduleId,
                      scheduleDateTime: reminderDateTime,
                      title: stickerController.text,
                      body: contentController.text);
                  addTask(
                      scheduleId,
                      contentController.text,
                      dateTime,
                      stickerController.text,
                      false,
                      reminder,
                      reminderDateTime);

                  Navigator.pop(context);
                  return;
                }
                addTask(scheduleId, contentController.text, dateTime,
                    stickerController.text, false, reminder, reminderDateTime);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: TextField(
              controller: stickerController,
              maxLines: 1,
              maxLength: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40.0,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(
                    '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'))
              ],
              decoration: InputDecoration(
                  hintText: "🌹",
                  counter: const Offstage(),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          const BorderSide(color: Colors.black12, width: 1.0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: TextField(
              controller: contentController,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: 8,
              decoration: InputDecoration(
                  hintText: 'Task',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          const BorderSide(color: Colors.black12, width: 1.0))),
            ),
          ),
          DateTimePicker(
              title: 'Date & Time',
              firstDate: DateTime.now(),
              lastDate: DateTime(
                  DateTime.now().year + 1,
                  DateTime.now().month,
                  DateTime.now().day,
                  DateTime.now().hour,
                  DateTime.now().minute),
              defaultDate: dateTime,
              onSelect: (v) {
                setState(() {
                  dateTime = v;
                });
              }),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: SwitchListTile.adaptive(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(15.0)),
                title: const Text('Reminder'),
                value: reminder,
                onChanged: (v) {
                  setState(() {
                    reminder = v;
                  });
                }),
          ),
          DateTimePicker(
              title: 'Remind On',
              firstDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 1, DateTime.now().month,
                  DateTime.now().day),
              defaultDate: reminderDateTime,
              onSelect: (v) {
                setState(() {
                  reminderDateTime = v;
                });
              }),
        ],
      )),
    );
  }

  void addTask(
      int scheduleId,
      String content,
      DateTime dateTime,
      String sticker,
      bool completed,
      bool reminder,
      DateTime reminderDateTime) {
    final userTask = Task()
      ..scheduleId = scheduleId
      ..content = content
      ..sticker = sticker
      ..dateTime = dateTime
      ..completed = completed
      ..reminder = reminder
      ..reminderDateTime = reminderDateTime;
    final box = Hive.box<Task>('usertasks');
    box.add(userTask);
  }
}
