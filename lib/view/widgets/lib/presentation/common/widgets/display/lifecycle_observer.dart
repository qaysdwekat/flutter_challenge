import 'package:flutter/material.dart';

class LifecycleObserver extends StatefulWidget {
  final Widget child;
  final Function(AppLifecycleState) onStateChanged;

  const LifecycleObserver({super.key, required this.child, required this.onStateChanged});

  @override
  State<StatefulWidget> createState() => _LifecycleObserverState();
}

class _LifecycleObserverState extends State<LifecycleObserver> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    widget.onStateChanged(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
