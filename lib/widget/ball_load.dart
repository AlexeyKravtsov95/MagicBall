import 'package:flutter/material.dart';
import 'package:magic_ball/utils/images.dart';

class BallLoaderWidget extends StatelessWidget {
  final AnimationController controller;

  const BallLoaderWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: controller, curve: Curves.bounceIn),
      child: Image.asset(Images.loaderImage),
    );
  }
}
