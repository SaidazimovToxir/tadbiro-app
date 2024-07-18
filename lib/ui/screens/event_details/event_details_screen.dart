import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_event_app/data/models/event_model.dart';
import 'package:exam_event_app/data/models/event_status_model.dart';
import 'package:exam_event_app/services/firebase/event_service.dart';
import 'package:exam_event_app/services/firebase/event_status_service.dart';
import 'package:exam_event_app/ui/screens/event_details/widgets/detail_info_widget.dart';
import 'package:exam_event_app/ui/screens/home_screen/home_screen.dart';
import 'package:exam_event_app/ui/widgets/app_mini_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;
  const EventDetailsScreen({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final _eventStatusService = EventStatusService();
    final EventService _eventService = EventService();

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
                  event.imageUrl,
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
          DetailInfoWidget(
            event: event,
            checkUserRegister: false,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.teal,
              onPressed: () async {
                final data = await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildBottomSheet(context);
                  },
                );

                int userCount = data['userCount'];
                final paymentMethod = data['paymentMethod'];
                final currentUser = FirebaseAuth.instance.currentUser!.uid;
                try {
                  _eventStatusService.addEventStatus(
                    userCount: userCount,
                    eventId: event.id,
                    userId: currentUser,
                    paymentMethod: paymentMethod,
                    status: "Register",
                    reminderTime: Timestamp.fromDate(DateTime.now()),
                  );

                  _eventService.editEvent(
                    id: event.id,
                    nweUserCount: event.userCount + userCount,
                  );
                  
                } catch (e) {
                  if (context.mounted) {
                    AppFunctions.showErrorSnackBar(context, e.toString());
                  }
                }
              },
              child: const Text(
                "Ro'yxatdan o'tish",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    int selectedCount = 1;
    String selectedPayment = '';

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ro'yxatdan O'tish",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Joylar sonini tanlang",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (selectedCount > 1) selectedCount--;
                      });
                    },
                  ),
                  Text(
                    '$selectedCount',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        selectedCount++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "To'lov turini tanlang",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text('Click'),
                trailing: Radio(
                  value: 'Click',
                  groupValue: selectedPayment,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPayment = value!;
                    });
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text('Payme'),
                trailing: Radio(
                  value: 'Payme',
                  groupValue: selectedPayment,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPayment = value!;
                    });
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text('Naqd'),
                trailing: Radio(
                  value: 'Naqd',
                  groupValue: selectedPayment,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPayment = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.teal,
                      onPressed: () {
                        Navigator.pop(context, {
                          'userCount': selectedCount,
                          'paymentMethod': selectedPayment,
                        }); // Close bottom sheet
                        _showAlertDialog(context); // Show alert dialog
                      },
                      child: const Text(
                        "Keyingi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('assets/images/success.json'),
              const Text(
                "Tabriklaymiz!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                " Siz ${event.name} tadbiriga muaffaqiyatli ro'yxatdan o'tdingiz.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.teal,
                      onPressed: () {
                        _selectDateTime(context);
                      },
                      child: const Text(
                        "Eslatma belgilash",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomeScreen(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.teal,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            "Bosh Sahifa",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final _eventStatusService = EventStatusService();
        Navigator.pop(context);

        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        print('Selected Date and Time: $selectedDateTime');
        // _eventStatusService.editEventStatus(
        //   id: event.id,
        //   newReminderTime: Timestamp.fromDate(selectedDateTime),
        // );
      }
    }
  }
}
