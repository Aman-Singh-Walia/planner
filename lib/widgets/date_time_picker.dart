import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  final String title;
  final Icon? icon;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime defaultDate;
  final Function(DateTime v) onSelect;
  const DateTimePicker(
      {Key? key,
      required this.title,
      this.icon,
      this.color,
      this.padding,
      required this.firstDate,
      required this.lastDate,
      required this.defaultDate,
      required this.onSelect})
      : super(key: key);

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    dateTime = widget.defaultDate;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(15.0)),
        contentPadding: widget.padding,
        onTap: pickDateTime,
        tileColor: widget.color,
        title: Text(widget.title),
        subtitle: Text(DateFormat('dd-MM-yyyy  HH:mm').format(dateTime)),
        trailing: widget.icon,
      ),
    );
  }

  Future pickDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: widget.defaultDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );
    return selectedDate;
  }

  Future pickTime() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: widget.defaultDate.hour, minute: widget.defaultDate.minute),
    );
    return selectedTime;
  }

  Future pickDateTime() async {
    final selectedDate = await pickDate();
    if (selectedDate == null) return;
    final selectedTime = await pickTime();
    if (selectedTime == null) return;

    setState(() {
      dateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
    });
    widget.onSelect(dateTime);
  }
}
