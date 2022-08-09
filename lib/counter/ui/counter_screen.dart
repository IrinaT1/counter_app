import 'package:flutter/material.dart';
import 'package:framework_example/counter/models/counter_view_model.dart';
import 'package:clean_framework/clean_framework.dart';

import 'counter_presenter_actions.dart';

class CounterScreen extends Screen {
  final CounterViewModel viewModel;
  final CounterPresenterActions actions;

  const CounterScreen({required this.viewModel, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Framework Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              viewModel.counter,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => actions.onButtonTapped(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
