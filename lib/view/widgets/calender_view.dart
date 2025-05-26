import 'package:flutter/material.dart';

class CalenderView extends StatelessWidget {
  final String time;
  final String date;
  final int weeknumber;

  const CalenderView({super.key, required this.time, required this.date, required this.weeknumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          time,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 52, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            Text(
              date,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text(
              'KW $weeknumber',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}
