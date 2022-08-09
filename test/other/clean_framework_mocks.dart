// @dart = 2.7
import 'dart:async';

import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

class MockPipe<T> extends Mock implements Pipe<T> {
  MockPipe._internal();

  factory MockPipe() {
    final mockPipe = MockPipe<T>._internal();
    when(mockPipe.receive)
        .thenAnswer((invocation) => StreamController<T>().stream);
    return mockPipe;
  }
}

class MockBuildContext extends Mock implements BuildContext {
  MockBuildContext._internal();

  factory MockBuildContext() {
    final mockBuildContext = MockBuildContext._internal();
    when(mockBuildContext.dependOnInheritedWidgetOfExactType()).thenAnswer(
      (_) => MediaQuery(
        data: const MediaQueryData(
          size: Size.square(1),
        ),
        child: Container(),
      ),
    );
    when(mockBuildContext.findAncestorWidgetOfExactType()).thenAnswer(
      (_) => MediaQuery(
        data: const MediaQueryData(
          size: Size.square(1),
        ),
        child: Container(),
      ),
    );
    when(mockBuildContext.widget).thenReturn(
      MediaQuery(
        data: const MediaQueryData(
          size: Size.square(1),
        ),
        child: Container(),
      ),
    );

    return mockBuildContext;
  }
}

class MockRepositoryScope extends Fake implements RepositoryScope {
  @override
  Function(dynamic) subscription;
}

class MockRepository extends Mock implements Repository {
  static Entity _entity;
  static Entity _secondEntity;
  static RepositoryScope _scope;

  MockRepository._internal();

  factory MockRepository() {
    final mockRepository = MockRepository._internal();

    when(mockRepository.create(any, any)).thenAnswer((_) {
      _scope = MockRepositoryScope();
      return _scope;
    });
    when(mockRepository.containsScope()).thenAnswer((_) => _scope);
    when(mockRepository.runServiceAdapter(any, any))
        .thenAnswer((_) => Future.value(_entity));
    when(mockRepository.get(any)).thenAnswer((invocation) {
      final invocationTypeArgument = invocation.typeArguments.first;
      return _secondEntity.runtimeType == invocationTypeArgument
          ? _secondEntity
          : _entity;
    });
    return mockRepository;
  }

  set mockEntity(value) => _entity = value;
  set secondMockEntity(value) => _secondEntity = value;
  set scope(value) => _scope = value;
  MockRepositoryScope get scope => _scope;
}
