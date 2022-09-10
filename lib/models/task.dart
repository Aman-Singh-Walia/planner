import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late int scheduleId;

  @HiveField(1)
  late String content;

  @HiveField(2)
  late String sticker;

  @HiveField(3)
  late DateTime dateTime;

  @HiveField(4)
  late bool completed;

  @HiveField(5)
  late bool reminder;

  @HiveField(6)
  late DateTime reminderDateTime;
}
