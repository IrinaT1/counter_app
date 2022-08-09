import 'package:flutter_test/flutter_test.dart';
import 'package:framework_example/counter/bloc/counter_events.dart';
import 'package:framework_example/counter/ui/counter_presenter_actions.dart';
import 'package:mockito/mockito.dart';

import '../counter_mocks.dart';

void main() {
  group('CounterPresenterActions', () {
    test('onButtonTapped', () {
      var blocMock = CounterBlocMock();
      var actions = CounterPresenterActions(blocMock);

      actions.onButtonTapped();

      verify(blocMock.counterEventPipe.send(ButtonTapEvent())).called(1);
    });
  });
}
