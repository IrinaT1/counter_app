import 'package:flutter_test/flutter_test.dart';
import 'package:framework_example/counter/models/counter_view_model.dart';
import 'package:framework_example/counter/ui/counter_presenter.dart';
import 'package:framework_example/counter/ui/counter_presenter_actions.dart';
import 'package:framework_example/counter/ui/counter_screen.dart';
import 'package:mockito/mockito.dart';

import '../../other/clean_framework_mocks.dart';
import '../counter_mocks.dart';

void main() {
  group('CounterPresenter', () {
    var viewModel = CounterViewModel(counter: '5');

    test('getViewModelStream', () {
      var presenter = CounterPresenter();
      var blocMock = CounterBlocMock();

      presenter.getViewModelStream(blocMock);

      verify(blocMock.counterViewModelPipe.receive).called(1);
    });

    test('buildScreen', () {
      var presenter = CounterPresenter();
      var blocMock = CounterBlocMock();

      var result = presenter.buildScreen(
        MockBuildContext(),
        blocMock,
        viewModel,
      );

      expect(result, isA<CounterScreen>());
      expect(result.viewModel.counter, '5');
      expect(result.actions, isA<CounterPresenterActions>());
    });
  });
}
