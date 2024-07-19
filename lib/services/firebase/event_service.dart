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
    required int userCount,
    required String description,
    required String imageUrl,
    required GeoPoint geoPoint,
    required String userId,
  }) async {
    await _eventCollection.add({
      "name": name,
      "addedDate": addedDate,
      "endTime": endTime,
      "userCount": userCount,
      "description": description,
      "imageUrl": imageUrl,
      'geo-point': geoPoint,
      "userId": userId,
    });
  }

  Future<void> editEvent(
      {required String id, required int nweUserCount}) async {
    await _eventCollection.doc(id).update({
      "userCount": nweUserCount,
    });
  }

  
}
