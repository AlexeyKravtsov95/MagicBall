import 'package:magic_ball/domain/entity/prediction_model.dart';

abstract interface class IBallRepository {
  Future<PredictionModel> getPredictionText();
}
