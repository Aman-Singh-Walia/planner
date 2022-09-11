import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String currentTheme = 'system';

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
          title: const Text('Settings')),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<String>('appTheme').listenable(),
        builder: (context, value, child) {
          final b = Hive.box<String>('appTheme');
          final themeChoice = b.get('themeChoice');
          currentTheme = themeChoice ?? 'system';
          return ListView(
            children: [
              ListTile(
                title: const Text('Theme'),
                trailing: Icon(
                  currentTheme == 'dark'
                      ? CupertinoIcons.moon_fill
                      : currentTheme == 'light'
                          ? CupertinoIcons.brightness_solid
                          : CupertinoIcons.circle_lefthalf_fill,
                ),
              ),
              SwitchListTile(
                  title: const Text('Light'),
                  value: currentTheme == "light",
                  onChanged: (v) {
                    b.put('themeChoice', 'light');
                  }),
              SwitchListTile(
                  title: const Text('Dark'),
                  value: currentTheme == "dark",
                  onChanged: (v) {
                    b.put('themeChoice', 'dark');
                  }),
              SwitchListTile(
                  title: const Text('System'),
                  value: currentTheme == "system",
                  onChanged: (v) {
                    b.put('themeChoice', 'system');
                  })
            ],
          );
        },
      ),
    );
  }
}
