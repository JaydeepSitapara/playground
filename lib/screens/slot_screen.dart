import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AddSlotScreen extends StatefulWidget {
  const AddSlotScreen({super.key});
  @override
  State<AddSlotScreen> createState() {
    return _AddSlotScreenState();
  }
}

class _AddSlotScreenState extends State<AddSlotScreen> {
  List<Map<String, String>> slotList = [];

  List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Tursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final DateFormat timeFormat = DateFormat('hh:mm a');

  bool isConflict(String day, String startTime, String endTime) {
    DateTime newStartTime = timeFormat.parse(startTime);
    DateTime newEndTime = timeFormat.parse(endTime);

    for (var slot in slotList) {
      if (slot['day'] == day) {
        DateTime existingStartTime = timeFormat.parse(slot['startTime']!);
        DateTime existingEndTime = timeFormat.parse(slot['endTime']!);

        if ((existingStartTime == newStartTime &&
                existingEndTime == newEndTime) ||
            (newStartTime.isBefore(existingEndTime) &&
                newEndTime.isAfter(existingStartTime))) {
          return true;
        }
      }
    }
    return false;
  }

  void addSlots() {
    for (int i = 0; i < weekdays.length; i++) {
      String day = weekdays[i];
      String startTime = '12:30 PM';
      String endTime = '04:00 PM';

      if (!isConflict(day, startTime, endTime)) {
        slotList.add({
          'day': day,
          'startTime': startTime,
          'endTime': endTime,
        });
        log('slot added');
      } else {
        log('Conflict or Duplicate found for $day from $startTime to $endTime');
        break;
      }
    }
  }

  void printData() {
    for (var slot in slotList) {
      log("Slot : $slot");
    }
  }

  void clearSlotList() {
    slotList.clear();
    log('slot cleared');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Slot Screen'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                addSlots();
              },
              child: const Text('Add Slot')),
          TextButton(
              onPressed: () {
                printData();
              },
              child: const Text('Print Slot')),
          TextButton(
              onPressed: () {
                clearSlotList();
              },
              child: const Text('Clear Slot'))
        ],
      ),
    );
  }
}
