import 'package:flutter_test/flutter_test.dart';
import 'package:framework_example/counter/bloc/counter_bloc.dart';
import 'package:framework_example/counter/bloc/counter_events.dart';
import 'package:framework_example/counter/bloc/counter_use_case.dart';
import 'package:mockito/mockito.dart';

class CounterUseCaseMock extends Mock implements CounterUseCase {}

void main() {
  group('CounterBloc', () {
    //#region Setup tests...
    late CounterBloc counterBloc;
    late CounterUseCaseMock useCaseMock;

    setUp(() {
      useCaseMock = CounterUseCaseMock();
      counterBloc = CounterBloc(counterUseCase: useCaseMock);
    });

    tearDown(() {
      counterBloc.dispose();
    });
    //#endregion

    test('creates without errors', () {
      // For coverage without mock use case.
      var counterBloc = CounterBloc();
      expect(counterBloc, isNotNull);
    });

    test('sends viewModelRequest', () {
      counterBloc.counterViewModelPipe.receive.listen((event) {});
      verify(useCaseMock.create()).called(1);
    });

    test('handles button event', () async {
      counterBloc.counterEventPipe.receive.listen(expectAsync1((event) {
        verify(useCaseMock.incrementCounter()).called(1);
      }));
      counterBloc.counterEventPipe.send(ButtonTapEvent());

      // //OR:
      // await Future.delayed(Duration.zero);
      // verify(useCaseMock.incrementCounter()).called(1);
    });
  });
}
