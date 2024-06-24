import 'package:flutter/material.dart';

class BallSuccessWidget extends StatefulWidget {
  const BallSuccessWidget({super.key, required this.text});
  final String text;

  @override
  State<BallSuccessWidget> createState() => _BallSuccessWidgetState();
}

class _BallSuccessWidgetState extends State<BallSuccessWidget>
    with TickerProviderStateMixin {
  late final Animation<double> _animation;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _animation,
        child: Text(
          widget.text,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
