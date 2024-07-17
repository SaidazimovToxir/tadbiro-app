import 'package:exam_event_app/ui/screens/event_screen/add_event_screen.dart';
import 'package:exam_event_app/ui/screens/event_screen/event_tap_pages/cancelled_events_page.dart';
import 'package:exam_event_app/ui/screens/event_screen/event_tap_pages/organizer_events_page.dart';
import 'package:exam_event_app/ui/screens/event_screen/event_tap_pages/participated_events_page.dart';
import 'package:exam_event_app/ui/screens/event_screen/event_tap_pages/resent_events_page.dart';
import 'package:flutter/material.dart';

class MyEventsScreen extends StatelessWidget {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Events'),
          bottom: const TabBar(
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 16.0),
            tabs: [
              Tab(text: 'Tashkil etganlarim'),
              Tab(text: 'Yaqinda'),
              Tab(text: 'Ishtirok etganlarim'),
              Tab(text: 'Bekor qilganlarim'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OrganizerEventsPage(),
            RecentEventsPage(),
            ParticipatedEventsPage(),
            CancelledEventsPage(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddEventScreen(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
