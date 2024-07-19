import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_event_app/data/models/event_model.dart';
import 'package:exam_event_app/data/models/event_status_model.dart';
import 'package:exam_event_app/services/firebase/auth_service.dart';
import 'package:exam_event_app/ui/screens/event_details/widgets/yandex_map_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class DetailInfoWidget extends StatefulWidget {
  final EventModel event;
  final EventStatusModel? eventStatus;
  final bool checkUserRegister;
  const DetailInfoWidget({
    super.key,
    required this.event,
    required this.checkUserRegister,
    this.eventStatus,
  });

  @override
  State<DetailInfoWidget> createState() => _DetailInfoWidgetState();
}

class _DetailInfoWidgetState extends State<DetailInfoWidget> {
  final _authService = UserAuthService();

  Future<List<Placemark>> _getPlacemarks(
      double latitude, double longitude) async {
    return await placemarkFromCoordinates(latitude, longitude);
  }

  Future<DocumentSnapshot> _loadCurrentUser() async {
    DocumentSnapshot user = await _authService.getUserInfo(widget.event.userId);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    DateTime addedDate = widget.event.addedDate.toDate();
    String formattedDate = DateFormat("dd MMMM yyyy").format(addedDate);
    DateTime startTime = widget.event.addedDate.toDate();
    DateTime endTIme = widget.event.endTime.toDate();
    String startTimeFormatted = DateFormat("EEEE, h:mm a").format(startTime);
    String endTimeFormatted = DateFormat("h:mm a").format(endTIme);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.event.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Card(
              color: Colors.teal,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.calendar_month,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(formattedDate),
            subtitle: Text("$startTimeFormatted - $endTimeFormatted"),
          ),
          FutureBuilder(
            future: _getPlacemarks(widget.event.geoPoint.latitude,
                widget.event.geoPoint.longitude),
            builder: (context, placemarkSnapshot) {
              if (placemarkSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const ListTile(
                  title: Center(child: CircularProgressIndicator()),
                );
              } else if (placemarkSnapshot.hasError ||
                  !placemarkSnapshot.hasData) {
                return ListTile(
                  title: Text(widget.event.name),
                  subtitle: const Text('Error loading location'),
                );
              } else {
                final placemarks = placemarkSnapshot.data!;
                final placemark =
                    placemarks.isNotEmpty ? placemarks.first : null;
                return ListTile(
                  leading: const Card(
                    color: Colors.teal,
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.location_on,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(placemark?.street ?? 'Unknown Street'),
                  subtitle: Text(placemark?.locality ?? "Unknown Country"),
                );
              }
            },
          ),
          ListTile(
            leading: const Card(
              color: Colors.teal,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.person,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text("${widget.event.userCount}  kishi qatnashmoqda"),
            subtitle: const Text("Siz ham ro'yxatdan o'ting"),
          ),
          FutureBuilder(
            future: _loadCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Text("Malumot topilmadi");
              }
              final user = snapshot.data;
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Container(
                    clipBehavior: Clip.hardEdge,
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.network(
                      user?['photoUrl'] ??
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWwfGUCDwrZZK12xVpCOqngxSpn0BDpq6ewQ&s",
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(user?['userName'] ?? "User yo'q"),
                  subtitle: const Text("Tadbir tashkilotchisi"),
                ),
              );
            },
          ),
          const Gap(20.0),
          Text(widget.event.description),
          const Gap(20),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: EventLocationMap(
              eventLocation: Point(
                latitude: widget.event.geoPoint.latitude,
                longitude: widget.event.geoPoint.longitude,
              ),
            ),
          ),
          const Gap(80.0),
        ],
      ),
    );
  }
}
