import 'package:simple_streaming_app/core/errors/exceptions/base_exception.dart';

class InternalDeviceConnectionTimeoutException extends BaseException{
  final String message;

  InternalDeviceConnectionTimeoutException({
    this.message = 'Connection to API server failed due to connection timeout'
  }): super(message);
}

