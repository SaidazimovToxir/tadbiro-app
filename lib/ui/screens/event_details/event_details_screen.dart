import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_event_app/data/models/event_model.dart';
import 'package:exam_event_app/services/firebase/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatefulWidget {
  final EventModel event;
  const EventDetailsScreen({
    super.key,
    required this.event,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  Future<List<Placemark>> _getPlacemarks(
      double latitude, double longitude) async {
    return await placemarkFromCoordinates(latitude, longitude);
  }

  @override
  void initState() {
    super.initState();
  }

  final _authService = UserAuthService();

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
    // String
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                height: 300,
                width: double.infinity,
                child: Image.network(
                  widget.event.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 35,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.favorite),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
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
                        subtitle:
                            Text(placemark?.locality ?? "Unknown Country"),
                      );
                    }
                  },
                ),
                const ListTile(
                  leading: Card(
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
                  title: Text("234 kishi bormoqda"),
                  subtitle: Text("Siz ham ro'yxatdan o'ting"),
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
                Text(widget.event.description)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
