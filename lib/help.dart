import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.yellow,
      appBar: AppBar(
            leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
        title: const Center(child:  Text('Help',style: TextStyle(color: Colors.white), )),
        //leading: const Center(child: Icon(Icons.help)),
      ),
    );
  }
}