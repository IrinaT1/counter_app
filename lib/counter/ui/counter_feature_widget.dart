import 'package:flutter/material.dart';
import 'package:framework_example/counter/bloc/counter_bloc.dart';
import 'package:framework_example/counter/ui/counter_presenter.dart';
import 'package:clean_framework/clean_framework.dart';

class CounterFeatureWidget extends StatelessWidget {
  const CounterFeatureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (_) => CounterBloc(),
      child: CounterPresenter(),
    );
  }
}
