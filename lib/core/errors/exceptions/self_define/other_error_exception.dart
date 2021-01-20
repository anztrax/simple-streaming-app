import '../base_exception.dart';

class OtherErrorException extends BaseException{
  final String message;

  OtherErrorException({
    this.message = 'Unknown Error'
  }): super(message);
}