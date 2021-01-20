import 'package:simple_streaming_app/core/domain/result.dart';
import 'package:simple_streaming_app/core/errors/exceptions/base_exception.dart';
import 'package:simple_streaming_app/core/errors/exceptions/self_define/code_exception.dart';
import 'package:simple_streaming_app/core/errors/exceptions/self_define/internal_device_connection_timeout_exception.dart';
import 'package:simple_streaming_app/core/errors/exceptions/self_define/internal_device_offline_network_exception.dart';
import 'package:simple_streaming_app/core/errors/failures/connection_timeout_failure.dart';
import 'package:simple_streaming_app/core/errors/failures/failure.dart';
import 'package:simple_streaming_app/core/errors/failures/network_offline_failure.dart';

typedef OtherExceptionCallback = Failure Function(BaseException exception);

abstract class BaseService {
  BaseService();

  Future<Result<Failure, T>> request<T>({
    OtherExceptionCallback otherErrorCallback,
    Function callback
  }) async {
    try {
      return Result.success(await callback());
    } catch (ex) {
      if (ex is InternalDeviceOfflineNetworkException) {
        return Result.failure(NetworkOfflineFailure());
      }

      if(ex is InternalDeviceConnectionTimeoutException){
        return Result.failure(ConnectionTimeoutFailure());
      }

      BaseException exceptionResult;

      if(ex is TypeError){
        exceptionResult = CodeException(
          message: ex.toString()
        );
      }else{
        exceptionResult = ex;
      }

      return Result.failure(otherErrorCallback(exceptionResult));
    }
  }
}
