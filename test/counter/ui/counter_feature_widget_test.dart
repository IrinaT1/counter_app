import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:framework_example/counter/bloc/counter_bloc.dart';
import 'package:framework_example/counter/ui/counter_feature_widget.dart';
import 'package:framework_example/counter/ui/counter_presenter.dart';

void main() {
  group('CounterFeatureWidget', () {
    testWidgets('content test', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: CounterFeatureWidget(),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(CounterPresenter), findsOneWidget);
      expect(find.byType(BlocProvider<CounterBloc>), findsOneWidget);
    });
  });
}
