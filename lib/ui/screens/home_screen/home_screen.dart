import 'package:carousel_slider/carousel_slider.dart';
import 'package:exam_event_app/data/models/event_model.dart';
import 'package:exam_event_app/services/firebase/event_service.dart';
import 'package:exam_event_app/ui/screens/event_details/event_details_screen.dart';
import 'package:exam_event_app/ui/screens/event_screen/widgets/get_location_name.dart';
import 'package:exam_event_app/ui/screens/notification_screen/notification_screen.dart';
import 'package:exam_event_app/ui/screens/home_screen/widgets/drawer.dart';
import 'package:exam_event_app/ui/screens/home_screen/widgets/search_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget publicText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  final List<String> imageUrls = [
    "https://imgs.search.brave.com/jBHjV2FBnc2_UMCIt2AnegzcdGOfXj40LS5HExccZX4/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTQw/NDIyMTY2NS9waG90/by9hYnN0cmFjdC1k/ZWZvY3VzZWQtbGVu/cy1jb2xvci1ncmFk/aWVudC1vbi1ibGFj/ay1iYWNrZ3JvdW5k/LndlYnA_Yj0xJnM9/MTcwNjY3YSZ3PTAm/az0yMCZjPWktRXFi/YzBvRDhiLUt0Ny1z/QVJSNW42SlhFQ2kw/aWhqUWFSeVFLMGg2/UFU9",
    "https://images.unsplash.com/photo-1499346030926-9a72daac6c63"
  ];

  final _eventService = EventService();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bosh sahifa"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationScreen(),
                ),
              );
            },
            icon: const Icon(Icons.notification_add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: MySearchField(),
            ),
          ),
          SliverToBoxAdapter(
            child: publicText("Yaqin 7 kun"),
          ),
          SliverToBoxAdapter(
            child: CarouselSlider.builder(
              itemCount: imageUrls.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(imageUrls[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Card(
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("12"),
                                    Text("May"),
                                  ],
                                ),
                              ),
                            ),
                            IconButton.filled(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite,
                              ),
                            ),
                          ],
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Qanaqadur mage festival"),
                            Text("mage festival"),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 250,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.98,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: publicText("Barcha tadbirlar"),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              left: 0.0,
              right: 0.0,
              bottom: 20.0,
            ),
            sliver: StreamBuilder(
              stream: _eventService.getEvents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (!snapshot.hasData || snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Error: ${snapshot.error}')),
                  );
                } else {
                  final data = snapshot.data!.docs;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final eventJson = data[index];
                        final EventModel event = EventModel.fromJson(eventJson);

                        return Hero(
                          tag: event.id,
                          child: GetLocationName(
                            event: event,
                            isOrganizer: false,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EventDetailsScreen(
                                    event: event,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      childCount: data.length,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
