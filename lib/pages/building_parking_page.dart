import 'package:flutter/material.dart';

class BuildingParkingPage extends StatelessWidget {
  const BuildingParkingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
             leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
        title: const Text('Building Parking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Building Parking',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Add your logic here for parking slot 1
              },
              child: const Text('Parking Slot 1'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your logic here for parking slot 2
              },
              child: const Text('Parking Slot 2'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your logic here for parking slot 3
              },
              child: const Text('Parking Slot 3'),
            ),
          ],
        ),
      ),
    );
  }
}
