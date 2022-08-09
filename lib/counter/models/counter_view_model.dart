import 'package:clean_framework/clean_framework.dart';

class CounterViewModel extends ViewModel {
  final String counter;

  CounterViewModel({
    required this.counter,
  });

  @override
  List<Object> get props => [
        counter,
      ];
}
