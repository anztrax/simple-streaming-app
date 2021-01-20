import 'package:meta/meta.dart';

abstract class Failure{
  final String message;

  Failure({
    @required this.message
  });
}

