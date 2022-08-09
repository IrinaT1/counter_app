import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:framework_example/counter/bloc/counter_use_case.dart';
import 'package:framework_example/counter/models/counter_entity.dart';
import 'package:framework_example/counter/models/counter_view_model.dart';
import 'package:mockito/mockito.dart';

import '../../other/clean_framework_mocks.dart';

//#region Set up dummy functions...
class DummyFunctions {
  bool viewModelCallBack(ViewModel viewModel) => true;
}

class MockDummyFunctions extends Mock implements DummyFunctions {
  @override
  bool viewModelCallBack(ViewModel? model) => super.noSuchMethod(
        Invocation.method(#callback, [model]),
      );
}
//#endregion

void main() {
  group('CounterUseCase', () {
    //#region Test setup...
    late MockDummyFunctions dummyFunctions;
    late MockRepository mockRepository;
    late CounterUseCase useCase;

    setUp(() {
      dummyFunctions = MockDummyFunctions();
      mockRepository = MockRepository();
      mockRepository.mockEntity = CounterEntity(counter: 5);
      useCase = CounterUseCase(
        dummyFunctions.viewModelCallBack,
        repository: mockRepository,
      );
    });

    CounterViewModel getSentModel() {
      List<dynamic> models =
          verify(dummyFunctions.viewModelCallBack(captureAny)).captured;
      expect(models.length, 1);
      expect(models.single, isA<CounterViewModel>());
      return models.single;
    }
    //#endregion

    test('creates without errors', () {
      var useCase = CounterUseCase(dummyFunctions.viewModelCallBack);
      expect(useCase, isNotNull);
    });

    test('sendViewModelRequest', () {
      useCase.create();
      expect(getSentModel().counter, '5');
    });

    test('buildViewModel', () {
      var viewModel = useCase.buildViewModel(CounterEntity(counter: 42));
      expect(viewModel.counter, '42');
    });

    test('incrementCounter', () {
      mockRepository.mockEntity = CounterEntity(counter: 5);
      mockRepository.scope = RepositoryScope((_) {});

      useCase.incrementCounter();
      verify(mockRepository.update(any, CounterEntity(counter: 6)));
      verify(dummyFunctions.viewModelCallBack(any)).called(1);

      mockRepository.mockEntity = CounterEntity(counter: 6);
      useCase.incrementCounter();
      verify(mockRepository.update(any, CounterEntity(counter: 7)));
      verify(dummyFunctions.viewModelCallBack(any)).called(1);
    });
  });
}
