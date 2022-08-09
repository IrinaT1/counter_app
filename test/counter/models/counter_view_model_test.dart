import 'package:flutter_test/flutter_test.dart';
import 'package:framework_example/counter/models/counter_view_model.dart';

void main() {
  group('CounterViewModel', () {
    test('comparison test', () {
      expect(CounterViewModel(counter: '5'), CounterViewModel(counter: '5'));
      expect(CounterViewModel(counter: '7'),
          isNot(CounterViewModel(counter: '8')));
    });

    //OR:
    // test('props test', () {
    //   var entity = CounterViewModel(counter: '5');
    //   expect(entity.props, [
    //     '5',
    //   ]);
    // });
  });
}
