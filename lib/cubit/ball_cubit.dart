import 'package:bloc/bloc.dart';
import 'package:magic_ball/domain/entity/prediction_model.dart';
import 'package:magic_ball/domain/repository/ball_repository.dart';

part 'ball_state.dart';

class BallCubit extends Cubit<BallState> {
  final IBallRepository _ballRepository;
  BallCubit(this._ballRepository) : super(BallInitial());

  Future<void> getPredictionText() async {
    emit(BallLoading());
    try {
      final text = await _ballRepository.getPredictionText();
      emit(
        BallSuccess(
          prediction: text,
        ),
      );
    } catch (e) {
      emit(BallError(
        errorMessage: e.toString(),
      ));
    }
  }
}
