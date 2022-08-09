import 'package:flutter/material.dart';
import 'package:framework_example/counter/ui/counter_feature_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Framework Counter Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterFeatureWidget(),
    );
  }
}

bool isPrime(int number) {
  return false;
}