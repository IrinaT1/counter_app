import 'package:framework_example/counter/bloc/counter_events.dart';
import 'package:framework_example/counter/models/counter_view_model.dart';
import 'package:clean_framework/clean_framework.dart';

import 'counter_use_case.dart';

class CounterBloc extends Bloc {
  late final CounterUseCase _useCase;

  final counterViewModelPipe = Pipe<CounterViewModel>();
  final counterEventPipe = Pipe<CounterEvent>(canSendDuplicateData: true);

  @override
  void dispose() {
    counterViewModelPipe.dispose();
    counterEventPipe.dispose();
  }

  CounterBloc({CounterUseCase? counterUseCase}) {
    _useCase = counterUseCase ?? CounterUseCase(viewModelCallback);

    counterViewModelPipe.whenListenedDo(() => _useCase.create());
    counterEventPipe.receive.listen(_counterEventHandler);
  }

  bool viewModelCallback(CounterViewModel viewModel) {
    if (viewModel is CounterViewModelWithError) {
      return counterViewModelPipe.throwError(Error());
    } else {
      return counterViewModelPipe.send(viewModel);
    }
  }

  void _counterEventHandler(CounterEvent event) {
    if (event is ButtonTapEvent) {
      _useCase.incrementCounter();
    }
  }
}
