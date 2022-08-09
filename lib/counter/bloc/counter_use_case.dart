import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:flutter/material.dart';
import 'package:framework_example/counter/models/counter_entity.dart';
import 'package:framework_example/counter/models/counter_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:framework_example/locator.dart';
import 'package:framework_example/other/repository_extensions.dart';

class CounterUseCase extends UseCase {
  late final Repository _repository;
  final ViewModelCallback<CounterViewModel> _viewModelCallBack;

  CounterUseCase(
    ViewModelCallback<CounterViewModel> viewModelCallBack, {
    Repository? repository,
  })  : _viewModelCallBack = viewModelCallBack,
        _repository = repository ?? repo();

  void create() {
    RepositoryScope? scope = _repository.containsScope<CounterEntity>();
    if (scope == null) {
      final newEntity = CounterEntity();
      scope = _repository.create<CounterEntity>(
        newEntity,
        _notifySubscribers,
        deleteIfExists: true,
      );
    } else {
      scope.subscription = _notifySubscribers;
    }

    final entity = _repository.get<CounterEntity>(scope);
    _notifySubscribers(entity);
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
    return CounterViewModel(
      counter: '${entity.counter}',
    );
  }
}
