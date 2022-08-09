import 'package:framework_example/counter/bloc/counter_events.dart';

import '../bloc/counter_bloc.dart';

class CounterPresenterActions {
  final CounterBloc bloc;

  const CounterPresenterActions(this.bloc);

  void onButtonTapped() {
    bloc.counterEventPipe.send(ButtonTapEvent());
  }
}