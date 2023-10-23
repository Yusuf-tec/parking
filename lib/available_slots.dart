import 'package:flutter/material.dart';
import 'package:parking/models/slot.dart';
import 'package:parking/models/parking.dart';

import 'map_direction.dart';


class AvailableSlotsPage extends StatefulWidget {
  final Parking parking;
  final List<Slot> availableSlots;


  const AvailableSlotsPage({super.key, required this.parking, required this.availableSlots,});

  @override
  State<AvailableSlotsPage> createState() => _AvailableSlotsPageState();
}

class _AvailableSlotsPageState extends State<AvailableSlotsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Available Slots')),
         
      ),
      body: Center(
        child: ListView.builder(
          itemCount: widget.availableSlots.length,
          itemBuilder: (context, index) {
            final slot = widget.availableSlots[index];
            return ListTile(
              title: Center(child: Text(widget.availableSlots[index].number)),
              onTap: () {
                launchMapDirections(widget.availableSlots[index].latitude, widget.availableSlots[index].longitude);
              },
            );
          },
        ),
      ),
    );
  }
}
