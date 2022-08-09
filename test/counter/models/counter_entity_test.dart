import 'package:flutter_test/flutter_test.dart';
import 'package:framework_example/counter/models/counter_entity.dart';

void main() {
  group('CounterEntity', () {
    test('comparison test', () {
      expect(CounterEntity(counter: 5), CounterEntity(counter: 5));
      expect(CounterEntity(counter: 7), isNot(CounterEntity(counter: 8)));
    });

    //OR:
    // test('props test', () {
    //   var entity = CounterEntity();
    //   expect(entity.props, [
    //     [],
    //     0,
    //   ]);
    // });

    test('merge test', () {
      var entity = CounterEntity(counter: 10);
      entity = entity.merge(counter: 11);
      expect(entity.counter, 11);

      // This is to fix really weird issues with coverage
      entity = entity.merge(errors: []);
      expect(entity.errors, []);
      entity = entity.merge();
    });
  });
}
