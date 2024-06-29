import 'package:flutter/material.dart';

class BallSuccessWidget extends StatelessWidget {
  final AnimationController controller;
  final String text;

  const BallSuccessWidget(
      {super.key, required this.controller, required this.text});

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    );
    return Center(
      child: FadeTransition(
        opacity: animation,
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
