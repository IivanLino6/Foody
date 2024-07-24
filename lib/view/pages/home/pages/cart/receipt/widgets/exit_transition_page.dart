import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ExitTransitionPage extends StatefulWidget {
  const ExitTransitionPage({super.key});

  @override
  State<ExitTransitionPage> createState() => _ExitTransitionPageState();
}


class _ExitTransitionPageState extends State<ExitTransitionPage> with TickerProviderStateMixin{
   late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Lottie.asset(
          "asset/Lottie/exit.json",
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward();
          },
        ),
      ),
    );
  }
}
