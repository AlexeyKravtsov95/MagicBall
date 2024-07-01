import 'package:flutter/material.dart';

class BallErrorWidget extends StatelessWidget {
  const BallErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Error. Try again',
      style:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.red),
    );
  }
}
