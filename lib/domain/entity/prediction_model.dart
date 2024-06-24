class PredictionModel {
  final String reading;

  PredictionModel({required this.reading});

  PredictionModel.fromJson(Map<String, dynamic> json)
      : reading = json['reading'] as String;
}
