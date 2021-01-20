import 'package:simple_streaming_app/core/errors/exceptions/base_exception.dart';

class CodeException implements BaseException{
  String message;

  CodeException({
    this.message
  });
}