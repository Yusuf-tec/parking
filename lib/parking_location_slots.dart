import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/models/slot.dart';
import 'package:parking/parking_deatails.dart';
import 'package:parking/providers/data_provider.dart';
import 'package:provider/provider.dart';

class ParkingLocationList extends StatefulWidget {
  final DataProvider dProvider = DataProvider();
  ParkingLocationList({super.key});

  @override
  State<ParkingLocationList> createState() => _ParkingLocationListState();
}

class _ParkingLocationListState extends State<ParkingLocationList> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text('Parking Locations')),
      ),
      body: RefreshIndicator(
        onRefresh: () => refreshPage(),
        child: FutureBuilder(
            future: dataProvider.getAllParkings(),
            builder: (context, snapshot) {
              return dataProvider.parkings.isEmpty
                  ? RefreshIndicator(
                      child: const CircularProgressIndicator(),
                      onRefresh: () => refreshPage())
                  : ListView.builder(
                      itemCount: dataProvider.parkings.length,
                      itemBuilder: (context, index) {
                        final parking = dataProvider.parkings[index];
                        return Card(
                          child: ListTile(
                            title: Center(child: Text(parking.name)),
                            subtitle: Center(
                                child: Text(
                                    'Total Slots: ${parking.slots.length}')),
                            onTap: () {
                              // Handle list item tap event if needed
                              // Navigator.push(context, MaterialPageRoute(builder: ((context) {
                              List<Slot> emptySlot = [];
                              setState(() {
                                for (var slot in parking.slots) {
                                  if (slot.isOccupied == 0) {
                                    emptySlot.add(slot);
                                  }
                                }
                                print('yu');
                                print(dataProvider.slots);

                                dataProvider.selectedParking = parking;
                                dataProvider.totalSlots = parking.slots.length;
                                dataProvider.availableSlots = emptySlot;
                              });
                              Get.to(ParkingDetailsPage());
                            },
                          ),
                        );
                      },
                    );
            }),
      ),
    );
  }

  refreshPage() {
    setState(() {
      widget.dProvider.refreshData();
    });
  }
}
