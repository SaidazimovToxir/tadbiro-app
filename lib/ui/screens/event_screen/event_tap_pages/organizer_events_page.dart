import 'package:exam_event_app/data/models/event_model.dart';
import 'package:exam_event_app/services/firebase/event_service.dart';
import 'package:flutter/material.dart';

class OrganizerEventsPage extends StatefulWidget {
  const OrganizerEventsPage({super.key});

  @override
  State<OrganizerEventsPage> createState() => _OrganizerEventsPageState();
}

class _OrganizerEventsPageState extends State<OrganizerEventsPage> {
  final _eventService = EventService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _eventService.getUserEvents('userID'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.hasError) {
          return Center(child: Text('error: snapshot: ${snapshot.error}'));
        } else {
          final data = snapshot.data!.docs;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final EventModel event = EventModel.fromJson(data[index]);
              return ListTile(
                title: Text(event.name),
              );
            },
          );
        }
      },
    );
  }
}
