import 'package:flutter/material.dart';
import 'package:flutter_challenge/view/prime_screen.dart';
import 'package:flutter_challenge/view/widgets/lib/presentation/common/widgets/display/lifecycle_observer.dart';
import 'package:flutter_challenge/viewmodel/number_view_model.dart';

import '../core/service_locator.dart';
import 'widgets/calender_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final NumberViewModel viewModel;

  @override
  void initState() {
    super.initState();
    // Inject view model from Service Locator
    viewModel = sl<NumberViewModel>();
    // Start Timer & fetching data from Service
    viewModel.startFetching();
    // Setup onPrimeFound callback
    viewModel.onPrimeFound = onPrimeFound;
  }

  void onPrimeFound(int prime, DateTime? date) async {
    // Stop timer (to avoid multi call of next screen) and navigate to the Prime screen
    viewModel.stopTimer();
    // Open next screen (PrimeScreen) and wait until close to restart the timer again.
    final _ = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PrimeScreen(prime: prime, lastPrimeTime: date)),
    );

    viewModel.startFetching();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey('home_screen'),
      backgroundColor: Colors.black,
      // Handle App states to stop the timer on app go in background & start it again when come to forground.
      body: LifecycleObserver(
        onStateChanged: (AppLifecycleState state) {
          if (state == AppLifecycleState.paused ||
              state == AppLifecycleState.inactive ||
              state == AppLifecycleState.detached) {
            viewModel.stopTimer();
          } else if (state == AppLifecycleState.resumed) {
            viewModel.startFetching();
          }
        },
        // Animation builder to trigger UI build when data change.
        // I used Animation builder with ChangeNotifier to handle AppState
        child: AnimatedBuilder(
          animation: viewModel,
          builder: (context, child) {
            return CalenderView(time: viewModel.time, date: viewModel.date, weeknumber: viewModel.weeknumber);
          },
        ),
      ),
    );
  }
}
