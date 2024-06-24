import 'package:flutter/material.dart';
import 'package:magic_ball/cubit/ball_cubit.dart';
import 'package:magic_ball/presentation/background_screen.dart';
import 'package:magic_ball/widget/ball_error.dart';
import 'package:magic_ball/widget/ball_init.dart';
import 'package:magic_ball/widget/ball_load.dart';
import 'package:magic_ball/widget/ball_success.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BallScreen extends StatefulWidget {
  const BallScreen({super.key});

  @override
  State<BallScreen> createState() => _BallScreenState();
}

class _BallScreenState extends State<BallScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: BlocBuilder<BallCubit, BallState>(
        builder: (context, state) {
          return BackgroundScreen(
              child: switch (state) {
            BallInitial() => const BallInitWidget(),
            BallSuccess() => BallSuccessWidget(text: state.prediction.reading),
            BallError() => const BallErrorWidget(),
            BallLoading() => const Center(
                child: BallLoaderWidget(),
              ),
          });
        },
      ),
    ));
  }
}
