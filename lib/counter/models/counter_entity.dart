import 'package:clean_framework/clean_framework.dart';

class CounterEntity extends Entity {
  final int counter;

  CounterEntity({
    List<EntityFailure> errors = const [],
    this.counter = 0,
  }) : super(errors: errors);

  @override
  List<Object> get props => [errors, counter];

  @override
  CounterEntity merge({List<EntityFailure>? errors, int? counter}) {
    return CounterEntity(
      errors: errors ?? this.errors,
      counter: counter ?? this.counter,
    );
  }
}
