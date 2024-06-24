import 'package:bloc/bloc.dart';
import 'package:magic_ball/data/repository/ball_repository_impl.dart';
import 'package:magic_ball/domain/entity/prediction_model.dart';

part 'ball_state.dart';

class BallCubit extends Cubit<BallState> {
  final BallRepositoryImpl _ballRepositoryImpl;
  BallCubit(this._ballRepositoryImpl) : super(BallInitial());

  Future<void> getPredictionText() async {
    emit(BallLoading());
    try {
      Duration duration = const Duration(milliseconds: 300);
      await Future.delayed(duration);
      final text = await _ballRepositoryImpl.getPredictionText();
      emit(
        BallSuccess(
          prediction: text,
        ),
      );
    } catch (e) {
      BallError(
        errorMessage: e.toString(),
      );
    }
  }
}
