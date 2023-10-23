import 'package:parking/models/slot.dart';

class Parking {
  final int id;
  final String name;
  final String pln;
  final String location;
  final List<Slot> slots;

  Parking({
    required this.id,
    required this.name,
    required this.pln,
    required this.location,
    required this.slots,
  });

  Parking.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['name'] != null),
        assert(map['pln'] != null),
        assert(map['location'] != null),
        id = map['id'],
        name = map['name'],
        pln = map['pln'],
        location = map['location'],
        slots = (map['slots'] as List).map((slot) => Slot.fromMap(slot)).toList();
}
