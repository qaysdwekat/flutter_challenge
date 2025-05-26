import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class PrimeScreen extends StatelessWidget {
  final int prime;
  final DateTime? lastPrimeTime;

  const PrimeScreen({required this.prime, this.lastPrimeTime}) : super(key: const ValueKey('prime_screen'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(color: Color(0xff69CF78), borderRadius: BorderRadius.circular(5)),
          width: 50,
          height: 10,
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Color(0xff151C20),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  Text(
                    'Congrats!',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'You obtained a prime number, it was: $prime',
                    key: ValueKey('prime_number'),
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  if (lastPrimeTime != null)
                    Text(
                      'Time since last prime number: ${timeago.format(lastPrimeTime!)}',
                      key: ValueKey('last_prime_number_date'),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Color(0xff737F83),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  else
                    Text(
                      'This is your first prime number',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Color(0xff737F83),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
              child: OutlinedButton(
                key: ValueKey('close_button'),
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xff69CF78),
                  foregroundColor: Color(0xff183921),
                  side: BorderSide(color: Color(0xff69CF78)),
                ),
                child: Text(
                  'Close',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Color(0xff183921), fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
