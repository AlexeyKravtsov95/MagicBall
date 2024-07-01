import 'dart:async';

import 'package:flutter/material.dart';
import 'package:magic_ball/cubit/ball_cubit.dart';
import 'package:magic_ball/presentation/background_screen.dart';
import 'package:magic_ball/utils/colors.dart';
import 'package:magic_ball/utils/images.dart';
import 'package:magic_ball/widget/ball_error.dart';
import 'package:magic_ball/widget/ball_load.dart';
import 'package:magic_ball/widget/ball_success.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shake/shake.dart';

class BallScreen extends StatefulWidget {
  const BallScreen({super.key});

  @override
  State<BallScreen> createState() => _BallScreenState();
}

class _BallScreenState extends State<BallScreen> with TickerProviderStateMixin {
  late final AnimationController _initController;
  late final AnimationController _loaderController;
  late final AnimationController _successController;
  late Animation<double> _ballAnimation;
  late ShakeDetector _shakeDetector;
  Timer? _resetTimer;

  @override
  void initState() {
    super.initState();

    _initController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _loaderController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _successController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _ballAnimation = Tween<double>(begin: 1.0, end: 2.7).animate(
      CurvedAnimation(
        parent: _initController,
        curve: Curves.easeIn,
      ),
    );

    _shakeDetector = ShakeDetector.waitForStart(onPhoneShake: () {
      if (_initController.status == AnimationStatus.dismissed) {
        _initController.forward().then((_) {
          context.read<BallCubit>().getPredictionText();
        });
      } else if (_initController.status == AnimationStatus.completed) {
        _initController.reverse();
      }
    });
    _shakeDetector.startListening();
  }

  @override
  void dispose() {
    _initController.dispose();
    _loaderController.dispose();
    _successController.dispose();
    _shakeDetector.stopListening();
    _resetTimer?.cancel();
    super.dispose();
  }

  void _onBallTapped() {
    if (_initController.status == AnimationStatus.dismissed) {
      _initController.forward().then((_) {
        context.read<BallCubit>().getPredictionText();
      });
    } else if (_initController.status == AnimationStatus.completed) {
      _initController.reverse();
    }
  }

  void _startResetTimer() {
    if (_resetTimer != null) {
      _resetTimer!.cancel();
    }
    _resetTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        _successController.reverse().then((_) {
          _initController.reverse();
          context.read<BallCubit>().resetBall();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<BallCubit, BallState>(
          listener: (context, state) {
            if (state is BallSuccess && !_successController.isAnimating) {
              _successController
                  .forward()
                  .whenComplete(() => _startResetTimer());
            } else if (state is BallInitial && _successController.isCompleted) {
              _successController.reverse();
            }
          },
          child: BlocBuilder<BallCubit, BallState>(
            builder: (context, state) {
              return BackgroundScreen(
                child: GestureDetector(
                    onTap: () => _onBallTapped(),
                    child: switch (state) {
                      BallInitial() => Container(
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
                                  scale: _ballAnimation,
                                  child: Image.asset(Images.backgroundImage),
                                ),
                              ),
                              Text(
                                'Нажмите на шар \nили потрясите телефон',
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      BallSuccess() => BallSuccessWidget(
                          controller: _successController,
                          text: state.prediction.reading),
                      BallError() => const BallErrorWidget(),
                      BallLoading() => Center(
                          child:
                              BallLoaderWidget(controller: _loaderController),
                        ),
                    }),
              );
            },
          ),
        ),
      ),
    );
  }
}
