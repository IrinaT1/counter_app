import 'package:clean_framework/clean_framework_defaults.dart';

class ExampleResponseModel extends JsonResponseModel {
  final int counter;

  ExampleResponseModel.fromJson(Map<String, dynamic> json)
      : counter = json['counter'] ?? '';

  @override
  List<Object> get props => [counter];
}
