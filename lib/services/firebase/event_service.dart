import 'package:cloud_firestore/cloud_firestore.dart';

class EventService {
  final _eventCollection = FirebaseFirestore.instance.collection("events");

  Stream<QuerySnapshot> getEvents() {
    return _eventCollection.snapshots();
  }

  Stream<QuerySnapshot> getUserEvents(String userId) {
    return _eventCollection
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  Future<void> addEvent({
    required String name,
    required Timestamp addedDate,
    required Timestamp endTime,
    required String description,
    required String imageUrl,
    required GeoPoint geoPoint,
    required String userId,
  }) async {
    await _eventCollection.add({
      "name": name,
      "addedDate": addedDate,
      "endTime": endTime,
      "description": description,
      "imageUrl": imageUrl,
      'geo-point': geoPoint,
      "userId": userId,
    });
  }
}
