import 'package:flutter/material.dart';
import 'package:magic_ball/utils/images.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
          Images.successImage,
          fit: BoxFit.cover,
        )),
        Positioned.fill(child: child),
      ],
    );
  }
}
