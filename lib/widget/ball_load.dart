import 'package:flutter/material.dart';
import 'package:magic_ball/utils/images.dart';

class BallLoaderWidget extends StatefulWidget {
  const BallLoaderWidget({super.key});

  @override
  State<BallLoaderWidget> createState() => _BallLoaderWidgetState();
}

class _BallLoaderWidgetState extends State<BallLoaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: _controller, curve: Curves.bounceIn),
      child: Image.asset(Images.loaderImage),
    );
  }
}
