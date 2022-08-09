import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:equatable/equatable.dart';

class ExampleRequestModel extends Equatable implements JsonRequestModel {
  final int currentCounter;

  const ExampleRequestModel({
    required this.currentCounter,
  });

  @override
  Map<String, String> toJson() {
    return {
      'example': currentCounter.toString(),
    };
  }

  @override
  List<Object> get props => [currentCounter];
}
