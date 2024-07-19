import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventStatusService {
  final _eventStatusCollection =
      FirebaseFirestore.instance.collection('eventStatus');

  Stream<QuerySnapshot> getEventStatus() {
    return _eventStatusCollection.snapshots();
  }

  Stream<QuerySnapshot> getEventStatusId(String eventId) {
    final user = FirebaseAuth.instance.currentUser;

    try {
      return _eventStatusCollection
          .where('eventId', isEqualTo: eventId)
          .where('userId', isEqualTo: user!.uid)
          .limit(1)
          .snapshots();
    } catch (e) {
      rethrow;
      // return _eventStatusCollection.where("eventId", isEqualTo: eventId).get();
    }
  }

  Future<void> addEventStatus({
    required int userCount,
    required String eventId,
    required String paymentMethod,
    required String userId,
    required String status,
    required Timestamp reminderTime,
  }) async {
    await _eventStatusCollection.add({
      "userCount": userCount,
      "eventId": eventId,
      "userId": userId,
      "paymentMethod": paymentMethod,
      "status": status,
      "reminderTime": reminderTime,
    });
  }

  Future<void> editEventStatus(
      {required String id, required Timestamp newReminderTime}) async {
    await _eventStatusCollection.doc(id).update({
      "reminderTime": newReminderTime,
    });
  }

  Future<void> editEventStatusName({
    required String id,
    required String newStatus,
  }) async {
    await _eventStatusCollection.doc(id).update({
      "status": newStatus,
    });
  }

  Future<void> deleteEventStatus(String id) async {
    return _eventStatusCollection.doc(id).delete();
  }
}
