import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_planner/app/data/theme/theme.dart';

class DateDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get current date
    DateTime date = DateTime.now();

    // Create a DateFormat instance for Indonesian locale
    DateFormat dateFormat = DateFormat.MMMEd('id');

    // Format the date
    String formattedDate = dateFormat.format(date);

    return Text(
      formattedDate,
      style: getSubtitleTextStyle.copyWith(height: .9),
    );
  }
}
