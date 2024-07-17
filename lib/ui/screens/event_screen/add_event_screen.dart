import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_event_app/services/firebase/event_service.dart';
import 'package:exam_event_app/ui/screens/event_screen/widgets/yandex_map_widget.dart';
import 'package:exam_event_app/ui/widgets/app_mini_functions.dart';
import 'package:exam_event_app/ui/widgets/custom_text_from_field.dart';
import 'package:exam_event_app/ui/widgets/manage_media.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventsScreenState();
}

class _AddEventsScreenState extends State<AddEventScreen> {
  TimeOfDay? _timeOfDay;
  DateTime? _dateTime;
  String? _imageUrl;

  final EventService _eventService = EventService();

  Point? _eventLocation;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _eNameController = TextEditingController();
  final TextEditingController _eDescriptionController = TextEditingController();

  void _onSaveTap() async {
    if (_formKey.currentState!.validate() &&
        _dateTime != null &&
        _timeOfDay != null &&
        _imageUrl != null &&
        _eventLocation != null) {
      // final String userID = await UserSharedPrefService().getUserId();
      try {
        _eventService.addEvent(
          userId: "userID",
          name: _eNameController.text,
          addedDate: Timestamp.fromDate(
            AppFunctions.combineDateTimeAndTimeOfDay(_dateTime!, _timeOfDay!),
          ),
          geoPoint:
              GeoPoint(_eventLocation!.latitude, _eventLocation!.longitude),
          description: _eDescriptionController.text,
          imageUrl: _imageUrl!,
        );
        if (mounted) {
          Navigator.of(context).pop();

          AppFunctions.showSnackBar(
            context,
            'New event has been added successully',
          );
        }
      } catch (e) {
        if (mounted) {
          AppFunctions.showErrorSnackBar(context, e.toString());
        }
      }
    } else {
      AppFunctions.showSnackBar(context, 'Please fill all fields');
    }
  }
  
  @override
  void dispose() {
    _eNameController.dispose();
    _eDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // leading: const ArrowBackButton(),
        title: const Text('Add event'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        hintText: 'Event name',
                        isObscure: false,
                        validator: (p0) =>
                            AppFunctions.textValidator(p0, 'event name'),
                        textEditingController: _eNameController,
                        isMaxLines: true,
                      ),
                      const Gap(15),
                      CustomTextFormField(
                        hintText: 'Description about event',
                        isObscure: false,
                        validator: (p0) => AppFunctions.textValidator(
                            p0, 'description about event'),
                        textEditingController: _eDescriptionController,
                        isMaxLines: true,
                      ),
                      const Gap(15),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton.icon(
                      icon: const Icon(Icons.date_range),
                      onPressed: () async {
                        final DateTime? chosenDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now().add(
                            const Duration(days: 1),
                          ),
                          lastDate: DateTime.now().add(
                            const Duration(days: 30),
                          ),
                        );
                        if (chosenDate != null) {
                          setState(() {
                            _dateTime = chosenDate;
                          });
                        }
                      },
                      label: const Text('Date'),
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.access_time_rounded),
                      onPressed: () async {
                        final TimeOfDay? chosenTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (chosenTime != null) {
                          setState(() {
                            _timeOfDay = chosenTime;
                          });
                        }
                      },
                      label: const Text('Time'),
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.picture_in_picture_rounded),
                      onPressed: () async {
                        final String? imageUrl = await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) =>
                              const ManageMedia(),
                        );
                        if (imageUrl != null) {
                          setState(() {
                            _imageUrl = imageUrl;
                          });
                        }
                      },
                      label: const Text('Picture'),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose location',
                  style: const TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  child: YandexMapWidget(
                    onLocationTap: (Point p0) {
                      _eventLocation = p0;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: _onSaveTap,
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
              child: Text(
            'Save',
            style: TextStyle(
              color: Colors.teal,
            ),
          )),
        ),
      ),
    );
  }

  
}
