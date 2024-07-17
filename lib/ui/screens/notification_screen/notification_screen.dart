import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:exam_event_app/ui/screens/notification_screen/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _value = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xabarlar"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        // SvgPicture.asset(
                        //   "assets/icons/bell2.svg",
                        //   width: 30,
                        // ),
                        const Gap(10.0),
                        const Text(
                          "Voice Reminder",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Switch.adaptive(
                          trackOutlineColor: WidgetStateColor.transparent,
                          inactiveTrackColor: Colors.black,
                          inactiveThumbColor: Colors.white,
                          activeColor: Colors.white,
                          activeTrackColor: Colors.blue,
                          value: _value,
                          onChanged: (bool newValue) {
                            setState(
                              () {
                                _value = newValue;
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              //? Test notificationlar.
              const NotificationWidget(
                isNewNotification: true,
                notificationText:
                    "Id id non excepteur consequat cupidatat magna esse quis ut veniam non cillum.",
                notificationDate: "01.02.2023 12:00",
              ),
              const NotificationWidget(
                isNewNotification: false,
                notificationText:
                    "Sit mollit pariatur laboris pariatur aliquip.Occaecat sunt ea veniam sit culpa elit officia labore aliquip ut excepteur ad dolor.",
                notificationDate: "01.02.2023 12:00",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
