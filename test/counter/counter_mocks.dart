import 'package:clean_framework/clean_framework.dart';
import 'package:framework_example/counter/bloc/counter_bloc.dart';
import 'package:framework_example/counter/bloc/counter_events.dart';
import 'package:framework_example/counter/models/counter_view_model.dart';
import 'package:mockito/mockito.dart';

import '../other/clean_framework_mocks.dart';

class CounterBlocMock extends Mock implements CounterBloc {
  @override
  Pipe<CounterViewModel> counterViewModelPipe = MockPipe();
  @override
  Pipe<CounterEvent> counterEventPipe = MockPipe();

  @override
  void dispose() {
    counterViewModelPipe.dispose();
    counterEventPipe.dispose();
  }
}
