import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_ball/cubit/ball_cubit.dart';
import 'package:magic_ball/utils/colors.dart';
import 'package:magic_ball/utils/images.dart';

class BallInitWidget extends StatelessWidget {
  final AnimationController controller;

  const BallInitWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.colorBackground,
            AppColors.colorBackgroundSecond,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: ScaleTransition(
              scale: animation,
              child: InkWell(
                child: Image.asset(
                  Images.backgroundImage,
                  fit: BoxFit.fitWidth,
                ),
                onTap: () async {
                  controller.addStatusListener((status) async {
                    if (status == AnimationStatus.dismissed) {
                      context.read<BallCubit>().getPredictionText();
                    }
                  });
                  controller.reverse();
                },
              ),
            ),
          ),
          Text(
            'Нажмите на шар \nили потрясите телефон',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
