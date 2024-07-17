import 'package:carousel_slider/carousel_slider.dart';
import 'package:exam_event_app/ui/screens/notification_screen/notification_screen.dart';
import 'package:exam_event_app/ui/screens/home_screen/widgets/drawer.dart';
import 'package:exam_event_app/ui/screens/home_screen/widgets/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
                  builder: (_) => NotificationScreen(),
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
                                padding: const EdgeInsets.all(6.0),
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
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            sliver: SliverList.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => const Gap(20.0),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.network(
                            "https://imgs.search.brave.com/BK9fvEJZ8USq8pEyUR14QkLsdvJYrsNlvmILMKFsEmU/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMuZnJlZWltYWdl/cy5jb20vaW1hZ2Vz/L2xhcmdlLXByZXZp/ZXdzLzU0Yy9ibHVl/LXNreS1ncmFkaWVu/dC0zLTEyNTU5MDAu/anBnP2ZtdA",
                            errorBuilder: (context, error, stackTrace) =>
                                const Text("Image"),
                          ),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "FLutter Global Hakathon",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text("10:00 06 Sentabr, 2024"),
                            Text("Yoshlar ijod saroyi"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton.filled(
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.black),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
