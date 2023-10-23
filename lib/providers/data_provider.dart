import 'dart:convert';
import 'package:parking/models/parking.dart';
import 'package:parking/models/slot.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class DataProvider extends ChangeNotifier {
  late Parking selectedParking;
  int totalSlots = 0;
  List<Slot> availableSlots = [];
  String api = "http://192.168.56.133:8000/api/";

  // ********** PARKINGS DATA ***********

  List<Parking> _parkings = [];
  List<Parking> get parkings => _parkings;
  set setParkings(List<Parking> emptyParkings) => _parkings = emptyParkings;

  Future<void> getAllParkings() async {
    List<Parking> fetchedParkings = [];
    try {
      final response = await http.get(Uri.parse('${api}parkings/'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        data['parkings'].forEach(($parking) {
          final dataSet = Parking.fromMap($parking);
          fetchedParkings.add(dataSet);
        });

        _parkings = fetchedParkings;
        print(_parkings);
        print(_parkings.length);
      }
    } catch (e) {
      print('Parkings Hazijaja');
      print(e);
    }
  }

  // SLOTS

  List<Slot> _slots = [];
  List<Slot> get slots => _slots;
  set setSlots(List<Slot> emptySlots) => _slots = emptySlots;

  Future<void> getAllSlots() async {
    List<Slot> fetchedSlots = [];
    try {
      final response = await http.get(Uri.parse('${api}slots/'));
      print("jujukuuuuuu");
      print(response);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        data['slots'].forEach(($slot) {
          final dataSet = Slot.fromMap($slot);
          fetchedSlots.add(dataSet);
        });

        _slots = fetchedSlots;
        print('GARI BOVUVUUUUUUVUUUUU');
        print(_slots);
        print(_slots.length);
      }
    } catch (e) {
      print('Slots Hazijaja');
      print(e);
    }
  }

  // Polling mechanism

  Timer? dataRefreshTimer;

  void startDataRefreshTimer() {
    const duration = Duration(minutes: 1);

    dataRefreshTimer = Timer.periodic(duration, (timer) {
      refreshData();
      notifyListeners();
    });
  }

  void stopDataRefreshTimer() {
    dataRefreshTimer?.cancel();
  }

  void refreshData() async {
    await getAllParkings();
    await getAllSlots();
    notifyListeners();
  }
}
