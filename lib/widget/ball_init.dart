import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_ball/cubit/ball_cubit.dart';
import 'package:magic_ball/utils/colors.dart';
import 'package:magic_ball/utils/images.dart';
import 'package:shake/shake.dart';

class BallInitWidget extends StatefulWidget {
  const BallInitWidget({super.key});

  @override
  State<BallInitWidget> createState() => _BallInitWidgetState();
}

class _BallInitWidgetState extends State<BallInitWidget>
    with TickerProviderStateMixin {
  late final Animation<double> _animation;
  late final AnimationController _controller;
  late ShakeDetector _detector;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _detector = ShakeDetector.waitForStart(onPhoneShake: () {
      context.read<BallCubit>().getPredictionText();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            child: FadeTransition(
              opacity: _animation,
              child: InkWell(
                child: Image.asset(
                  Images.backgroundImage,
                  fit: BoxFit.fitWidth,
                ),
                onTap: () async {
                  _controller.addStatusListener((status) async {
                    if (status == AnimationStatus.dismissed) {
                      context.read<BallCubit>().getPredictionText();
                    }
                  });
                  _controller.reverse();
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
