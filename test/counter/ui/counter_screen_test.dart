import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:framework_example/counter/models/counter_view_model.dart';
import 'package:framework_example/counter/ui/counter_presenter_actions.dart';
import 'package:framework_example/counter/ui/counter_screen.dart';
import 'package:mockito/mockito.dart';

class CounterActionsMock extends Mock implements CounterPresenterActions {}

void main() {
  var viewModel = CounterViewModel(counter: '5');

  late CounterActionsMock actionsMock;

  setUp(() {
    actionsMock = CounterActionsMock();
  });

  group('CounterScreen', () {
    Future<void> pumpCounterScreen(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CounterScreen(
          viewModel: viewModel,
          actions: actionsMock,
        ),
      ));
    }

    testWidgets('content test', (WidgetTester tester) async {
      await pumpCounterScreen(tester);
      await tester.pumpAndSettle();

      expect(find.text('You have pushed the button this many times:'),
          findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('tap test', (tester) async {
      await pumpCounterScreen(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));

      verify(actionsMock.onButtonTapped()).called(1);
    });
  });
}
