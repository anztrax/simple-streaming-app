import 'package:simple_streaming_app/core/errors/exceptions/base_exception.dart';

class RefreshingRefreshTokenException extends BaseException {
  final String message;

  RefreshingRefreshTokenException({
    this.message = "Cannot refreshing refresh token"
  }) : super(message);
}
