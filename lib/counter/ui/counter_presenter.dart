import 'package:flutter/material.dart';
import 'package:framework_example/counter/models/counter_view_model.dart';
import 'package:clean_framework/clean_framework.dart';

import '../bloc/counter_bloc.dart';
import 'counter_presenter_actions.dart';
import 'counter_screen.dart';

class CounterPresenter
    extends Presenter<CounterBloc, CounterViewModel, CounterScreen> {
  @override
  Stream<CounterViewModel> getViewModelStream(CounterBloc bloc) {
    return bloc.counterViewModelPipe.receive;
  }

  @override
  CounterScreen buildScreen(
    BuildContext context,
    CounterBloc bloc,
    CounterViewModel viewModel,
  ) {
    return CounterScreen(
      viewModel: viewModel,
      actions: CounterPresenterActions(bloc),
    );
  }

  @override
  Widget buildLoadingScreen(BuildContext context) => Container(
        key: const Key('waitingForStream'),
        color: Colors.white,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );

  @override
  Widget buildErrorScreen(BuildContext context, Object? error) => Container(
        key: const Key('noContentFromStream'),
        color: Colors.white,
        alignment: Alignment.center,
        child: const Text('Error'),
      );
}
