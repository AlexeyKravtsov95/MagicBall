part of 'ball_cubit.dart';

sealed class BallState {}

class BallInitial extends BallState {}

class BallLoading extends BallState {}

class BallSuccess extends BallState {
  PredictionModel prediction;

  BallSuccess({required this.prediction});
}

class BallError extends BallState {
  final String errorMessage;

  BallError({required this.errorMessage});
}
