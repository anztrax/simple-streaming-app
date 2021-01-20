import 'package:simple_streaming_app/core/errors/exceptions/http/base_http_exception.dart';

class BadRequestException extends BaseHttpException{
  static const code = 400;

  BadRequestException({
    dynamic responseData,
  }): super(
    responseData: responseData,
    responseCode: code
  );

  @override
  String toString() {
    return parseError();
  }
}