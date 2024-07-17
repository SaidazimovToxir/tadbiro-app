import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class EventModel {
  final String id;
  final String name;
  final Timestamp addedDate;
  final Timestamp endTime;
  final String description;
  final String imageUrl;
  final GeoPoint geoPoint;

  final String userId;

  EventModel({
    required this.id,
    required this.name,
    required this.addedDate,
    required this.endTime,
    required this.description,
    required this.imageUrl,
    required this.geoPoint,
    required this.userId,
  });

  factory EventModel.fromJson(QueryDocumentSnapshot query) {
    return EventModel(
      id: query.id,
      name: query['name'],
      addedDate: query['addedDate'],
      endTime: query['endTime'],
      description: query['description'],
      imageUrl: query['imageUrl'],
      geoPoint: query['geo-point'],
      userId: query['userId'],
    );
  }
}
