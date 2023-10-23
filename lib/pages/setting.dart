import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  bool _isAccessible = false;
  String _language = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text("Language"),
          const SizedBox(height: 10),
          DropdownButton<String>(
            value: _language,
            onChanged: (String? newValue) {
              setState(() {
                _language = newValue!;
              });
            },
            items: <String>['English', 'Swahili', 'French', 'German']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text("Theme"),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _isDarkMode,
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
                // Add code to change the theme here
              });
            },
          ),
          const SizedBox(height: 20),
          const Text("Accessibility"),
          SwitchListTile(
            title: const Text('Accessibility'),
            value: _isAccessible,
            onChanged: (bool value) {
              setState(() {
                _isAccessible = value;
                // Add code to make app more accessible here
                
              });
            },
          ),
        ],
      ),
    );
  }
}
