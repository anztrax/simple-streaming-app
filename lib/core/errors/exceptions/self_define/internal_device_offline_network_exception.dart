import 'package:simple_streaming_app/core/errors/exceptions/base_exception.dart';

class InternalDeviceOfflineNetworkException extends BaseException{
  final String message;

  InternalDeviceOfflineNetworkException({
    this.message = 'Connection to API server failed due to internet connection'
  }): super(message);
}

