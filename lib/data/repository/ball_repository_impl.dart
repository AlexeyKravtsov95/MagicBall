import 'package:dio/dio.dart';
import 'package:magic_ball/domain/entity/prediction_model.dart';
import 'package:magic_ball/domain/repository/ball_repository.dart';

class BallRepositoryImpl implements IBallRepository {
  final Dio dio;

  BallRepositoryImpl({required this.dio});

  @override
  Future<PredictionModel> getPredictionText() async {
    try {
      final response = await dio.get('https://eightballapi.com/api');
      return PredictionModel.fromJson(response.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
