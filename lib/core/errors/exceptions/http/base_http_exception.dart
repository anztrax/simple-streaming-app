import 'package:simple_streaming_app/core/errors/exceptions/base_exception.dart';

class BaseHttpException extends BaseException{
  static final String ERROR_MESSAGE_KEY = 'errorMessage';

  String message;
  dynamic responseData;
  int responseCode;

  BaseHttpException({
    this.message,
    this.responseData,
    this.responseCode
  }): super(message);

  String parseError(){
    return '${responseData[ERROR_MESSAGE_KEY]}';
  }
}