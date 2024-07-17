import 'package:exam_event_app/data/models/event_model.dart';
import 'package:exam_event_app/services/firebase/event_service.dart';
import 'package:exam_event_app/ui/screens/event_screen/widgets/get_location_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrganizerEventsPage extends StatefulWidget {
  const OrganizerEventsPage({super.key});

  @override
  State<OrganizerEventsPage> createState() => _OrganizerEventsPageState();
}

class _OrganizerEventsPageState extends State<OrganizerEventsPage> {
  final _eventService = EventService();
  late double lat;
  late double long;

  @override
  void initState() {
    lat = 52.2165157;
    long = 6.9437819;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: _eventService.getUserEvents(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final data = snapshot.data!.docs;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final eventJson = data[index];
              final EventModel event = EventModel.fromJson(eventJson);

              return GetLocationName(
                event: event,
                isOrganizer: true,
                onTap: () {},
              );
            },
          );
        }
      },
    );
  }
}
