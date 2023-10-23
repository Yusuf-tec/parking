import 'package:flutter/material.dart';
import 'package:parking/models/slot.dart';
import 'package:parking/models/parking.dart';
import 'package:parking/providers/data_provider.dart';
import 'package:provider/provider.dart';
import 'available_slots.dart';

class ParkingDetailsPage extends StatefulWidget {
  // final Parking parkingiiiiiiii;
  // final int totalSlots;
  // final List<Slot> availableSlots;
  final DataProvider dataProv=DataProvider();

   ParkingDetailsPage(
      {super.key});

  @override
  State<ParkingDetailsPage> createState() => _ParkingDetailsPageState();
}

class _ParkingDetailsPageState extends State<ParkingDetailsPage> {
  @override
  void initState() {
    super.initState();
    // widget.dataProv = Provider.of<DataProvider>(context, listen: false);
    //availableSlots = dataProvider.slots;

    // Start the data refresh timer when the page is loaded
    widget.dataProv.startDataRefreshTimer();
  }

  @override
  void dispose() {
    // Stop the data refresh timer when the page is disposed
    // dataProvider.stopDataRefreshTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Parking Details')),
      ),
      body: RefreshIndicator(
        onRefresh: () => refreshPage(),
        child: Center(
          child: FutureBuilder(
              future: dataProvider.getAllParkings(),
              builder: (context, snapshot) {
                return dataProvider.parkings.isEmpty
                    ? RefreshIndicator(
                        child: const CircularProgressIndicator(),
                        onRefresh: () => refreshPage())
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dataProvider.selectedParking.name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Total Slots: ${dataProvider.totalSlots}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AvailableSlotsPage(
                                    parking: dataProvider.selectedParking,
                                    availableSlots: dataProvider.availableSlots,
                                  
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Available Slots: ${dataProvider.availableSlots.length}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.blue),
                            ),
                          ),
                        ],
                      );
              }),
        ),
      ),
    );
  }

  refreshPage() {
    setState(() {
      widget.dataProv.refreshData();
    });
  }
}
