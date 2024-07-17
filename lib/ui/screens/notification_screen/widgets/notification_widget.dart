import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class NotificationWidget extends StatelessWidget {
  final bool isNewNotification;
  final String notificationText;
  final String notificationDate;
  const NotificationWidget({
    super.key,
    required this.isNewNotification,
    required this.notificationText,
    required this.notificationDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(20.0),
        Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                ),
                title: const Text("Azamat zokirov"),
                subtitle: const Text("example@gmail.com"),
                trailing: isNewNotification
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: const Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 2.0,
                          ),
                          child: Text(
                            "New",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              // ? Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       CircleAvatar()
              //       Container(
              //         decoration: BoxDecoration(
              //           color: Colors.blue,
              //           borderRadius: BorderRadius.circular(5.0),
              //         ),
              //         child: const Padding(
              //           padding: const EdgeInsets.symmetric(
              //             horizontal: 12.0,
              //             vertical: 2.0,
              //           ),
              //           child: Text(
              //             "New",
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 15.0,
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   )
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  notificationText,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.titleLarge!.color,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Text(
                notificationDate,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
