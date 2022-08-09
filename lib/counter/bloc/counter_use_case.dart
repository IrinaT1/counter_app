import 'dart:math';

import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:flutter/material.dart';
import 'package:framework_example/counter/models/counter_entity.dart';
import 'package:framework_example/counter/models/counter_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:framework_example/locator.dart';

class CounterUseCase extends UseCase {
  late final Repository _repository;
  final ViewModelCallback<CounterViewModel> _viewModelCallBack;

  CounterUseCase(
    ViewModelCallback<CounterViewModel> viewModelCallBack, {
    Repository? repository,
  })  : _viewModelCallBack = viewModelCallBack,
        _repository = repository ?? repo();

  Future<void> create() async {
    final entity = CounterEntity();
    _repository.create<CounterEntity>(
      entity,
      _notifySubscribers,
      deleteIfExists: true,
    );
    await Future.delayed(const Duration(milliseconds: 1000));
    _notifySubscribers(entity);
    // _notifySubscribers(entity.merge(errors: const [EntityFailure()]));
  }

  void _notifySubscribers(entity) {
    _viewModelCallBack(buildViewModel(entity));
  }

  void incrementCounter() {
    final scope = _repository.containsScope<CounterEntity>();
    final entity = _repository.get<CounterEntity>(scope!);

    final newEntity = entity.merge(counter: entity.counter + 1);
    _repository.update(scope, newEntity);
    _notifySubscribers(newEntity);
  }

  @visibleForTesting
  CounterViewModel buildViewModel(CounterEntity entity) {
    if (entity.hasErrors()) {
      return CounterViewModelWithError(
        counter: '${entity.counter}',
      );
    } else {
      return CounterViewModel(
        counter: '${entity.counter}',
      );
    }
  }
}
