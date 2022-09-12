import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planner/models/task.dart';
import 'package:planner/services/notification_api.dart';
import 'package:planner/widgets/alert_dialog.dart';
import 'package:planner/widgets/date_time_picker.dart';

class ViewEditTaskPage extends StatefulWidget {
  final Task task;
  const ViewEditTaskPage({super.key, required this.task});

  @override
  State<ViewEditTaskPage> createState() => _ViewEditTaskPageState();
}

class _ViewEditTaskPageState extends State<ViewEditTaskPage> {
  TextEditingController stickerController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  DateTime dateTime = DateTime.now();
  bool reminder = false;
  DateTime reminderDateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    stickerController.text = widget.task.sticker;
    contentController.text = widget.task.content;
    dateTime = widget.task.dateTime;
    reminder = widget.task.reminder;
    reminderDateTime = widget.task.reminderDateTime;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text('Task'),
        actions: [
          IconButton(
              onPressed: () {
                if (widget.task.content.isEmpty) {
                  showAlertDialog(
                      context, 'Alert', 'Could not save empty task');
                  return;
                }
                if (widget.task.sticker.isEmpty) {
                  widget.task.sticker = '🌹';
                }
                if (widget.task.reminder) {
                  if (widget.task.reminderDateTime
                          .isAfter(widget.task.dateTime) ||
                      widget.task.reminderDateTime.isBefore(DateTime.now())) {
                    showAlertDialog(context, 'Alert',
                        'Can not set reminder for the selected date and time');
                    return;
                  }
                  NotificationApi.showScheduledNotification(
                      id: widget.task.scheduleId,
                      scheduleDateTime: widget.task.reminderDateTime,
                      title: widget.task.sticker,
                      body: widget.task.content);
                  Navigator.pop(context);
                  return;
                }
                widget.task.save();
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
              onChanged: (v) {
                widget.task.sticker = v;
              },
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
              onChanged: (v) {
                widget.task.content = v;
              },
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
                  widget.task.dateTime = v;
                });
              }),
          SwitchListTile.adaptive(
              title: const Text('Reminder'),
              value: reminder,
              onChanged: (v) {
                setState(() {
                  widget.task.reminder = v;
                });
              }),
          DateTimePicker(
              title: 'Remind On',
              firstDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 1, DateTime.now().month,
                  DateTime.now().day),
              defaultDate: reminderDateTime,
              onSelect: (v) {
                setState(() {
                  widget.task.reminderDateTime = v;
                });
              }),
        ],
      )),
    );
  }
}
