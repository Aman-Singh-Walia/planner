import 'package:flutter/material.dart';

class ViewEditTaskPage extends StatefulWidget {
  const ViewEditTaskPage({super.key});

  @override
  State<ViewEditTaskPage> createState() => _ViewEditTaskPageState();
}

class _ViewEditTaskPageState extends State<ViewEditTaskPage> {
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
            title: const Text('Task')));
  }
}
