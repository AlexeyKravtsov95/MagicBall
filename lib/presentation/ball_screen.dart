import 'package:flutter/material.dart';
import 'package:magic_ball/cubit/ball_cubit.dart';
import 'package:magic_ball/presentation/background_screen.dart';
import 'package:magic_ball/widget/ball_error.dart';
import 'package:magic_ball/widget/ball_init.dart';
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
  late ShakeDetector _shakeDetector;

  @override
  void initState() {
    super.initState();

    _initController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _loaderController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _successController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this)
      ..forward();

    _shakeDetector = ShakeDetector.waitForStart(onPhoneShake: () {
      context.read<BallCubit>().getPredictionText();
    });
  }

  @override
  void dispose() {
    _initController.dispose();
    _loaderController.dispose();
    _successController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: BlocBuilder<BallCubit, BallState>(
        builder: (context, state) {
          return BackgroundScreen(
              child: switch (state) {
            BallInitial() => BallInitWidget(
                controller: _initController,
              ),
            BallSuccess() => BallSuccessWidget(
                controller: _successController, text: state.prediction.reading),
            BallError() => const BallErrorWidget(),
            BallLoading() => Center(
                child: BallLoaderWidget(controller: _loaderController),
              ),
          });
        },
      ),
    ));
  }
}
