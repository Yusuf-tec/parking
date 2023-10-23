class Slot {
  final int id;
  final int parkingId;
  final String number;
  final double latitude;
  final double longitude;
  final int isOccupied;

  Slot({
    required this.id,
    required this.parkingId,
    required this.number,
    required this.latitude,
    required this.longitude,
    required this.isOccupied,
  });

  Slot.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['number'] != null),
        assert(map['parking_id'] != null),
        assert(map['is_occupied'] != null),
        assert(map['latitude'].toDouble() != null),
        assert(map['longitude'].toDouble() != null),
        id = map['id'],
        number = map['number'],
        parkingId = map['parking_id'],
        longitude= map['longitude'].toDouble(),
        latitude = map['latitude'].toDouble(),
        isOccupied = map['is_occupied'];
}
