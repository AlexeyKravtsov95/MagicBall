import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:magic_ball/cubit/ball_cubit.dart';
import 'package:magic_ball/data/repository/ball_repository_impl.dart';
import 'package:magic_ball/presentation/ball_screen.dart';
import 'package:magic_ball/utils/colors.dart';

void main() {
  final dio = Dio();
  GetIt.I.registerSingleton<BallRepositoryImpl>(BallRepositoryImpl(dio: dio));
  runApp(const BallApp());
}

class BallApp extends StatelessWidget {
  const BallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BallCubit(GetIt.I<BallRepositoryImpl>()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Magic ball',
        theme: ThemeData(
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.colorGray,
            ),
            titleLarge: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
        home: const BallScreen(),
      ),
    );
  }
}
