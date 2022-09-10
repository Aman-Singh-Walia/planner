import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:planner/pages/add_task_page.dart';
import 'package:planner/pages/settings_page.dart';
import 'package:planner/widgets/all_tasks.dart';
import 'package:planner/widgets/completed_tasks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;
  List<Widget> tabs = const [AllTasks(), CompletedTasks()];
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planner'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddTaskPage()));
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: tabs[tabIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (v) {
            setState(() {
              tabIndex = v;
            });
          },
          currentIndex: tabIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: 'Tasks'),
            BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Completed')
          ]),
    );
  }
}
