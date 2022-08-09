import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';

Repository repo() => Locator().repository;

RestApi api() => Locator().api;

class Locator {
  static Locator? _instance;

  Locator._();

  factory Locator() {
    _instance ??= Locator._();
    return _instance!;
  }

  Repository repository = Repository();

  RestApi api = SimpleRestApi();
}
