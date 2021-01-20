import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:simple_streaming_app/core/errors/exceptions/http/bad_request_error_exception.dart';
import 'package:simple_streaming_app/core/errors/exceptions/http/base_http_exception.dart';
import 'package:simple_streaming_app/core/errors/exceptions/self_define/internal_device_connection_timeout_exception.dart';
import 'package:simple_streaming_app/core/errors/exceptions/self_define/internal_device_offline_network_exception.dart';
import 'package:simple_streaming_app/core/errors/exceptions/self_define/other_error_exception.dart';
import 'package:simple_streaming_app/core/file/file_manager.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;


abstract class HttpClient {
  static const int _TIMEOUT_MILLI_SECONDS = 20000;

  Dio client;
  String baseUrl;
  TempFileManager tempFileManager;

  HttpClient({
    this.baseUrl
  }) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: _TIMEOUT_MILLI_SECONDS,
      receiveTimeout: _TIMEOUT_MILLI_SECONDS,
    );
    tempFileManager = TempFileManager();

    this.client = Dio(options);
    this.interceptors();
  }
  
  void interceptors() {
    this.client.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        print("[DIO DEBUG] Request : { baseUrl: ${options.baseUrl}, path: ${options.path}, method: ${options.method}, contentType: ${options.contentType}, headers: ${options.headers}, queryParams: ${options.queryParameters}, data: ${options.data} }");
        return options;
      },
      onResponse: (Response response) {
        print('[DIO DEBUG] response options : ${response}');
        return response;
      },
      onError: (DioError error) async {
        print('[DIO DEBUG] error options : ${error.request}  # ${error.response}');
        return error;
      }
    ));
  }

  Future<TempFileManager> downloadFile({
    @required String uri,
  }) async{
    try {
      TempFileManager tempFileManager = TempFileManager();
      String finalTempFileName = "${Uuid().v4()}${path.extension(uri)}";
      await tempFileManager.initFile(finalTempFileName);
      Response response = await this.client.download(
        uri,
        tempFileManager.getFullFilePath(),
      );

      return tempFileManager;
    } catch(ex) {
      if (ex is DioError) {
        throw manageDioException(ex);
      }

      throw OtherErrorException(
        message: "Unknown Error !"
      );
    }
  }

  Future<dynamic> getDataFromRemoteTextFile({
    @required String uri,
    Map<String, dynamic> queryParams = const {},
  }) async {
    await tempFileManager.initFile('temp.file');

    try {
      Response response = await this.client.download(
        uri,
        tempFileManager.getFullFilePath(),
        queryParameters: queryParams
      );

      Map mapData = await tempFileManager.getMapData();
      if(response.statusCode == 200){
        return mapData;
      }

      tempFileManager.deleteFile();
      throw createHTTPException(
        statusCode: response.statusCode,
        jsonData: mapData
      );

    } catch(ex) {
      if (ex is DioError) {
        throw manageDioException(ex);
      }

      throw OtherErrorException(
        message: "Unknown Error !"
      );
    }
  }


  Exception createHTTPException({
    int statusCode,
    Map jsonData
  }){
    Exception exception = OtherErrorException( message: 'Other Error Response');
    switch (statusCode) {
      case BadRequestException.code:
        exception = BadRequestException(
          responseData: jsonData,
        );
        break;
      default:
        exception = BaseHttpException(
          responseData: null
        );
    }

    return exception;
  }

  Exception manageDioException(DioError error){
    switch(error.type){
      case DioErrorType.CANCEL:
        return OtherErrorException(
          message: 'Request API server was cancelled'
        );
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        return InternalDeviceConnectionTimeoutException();
        break;
      case DioErrorType.DEFAULT:
        return InternalDeviceOfflineNetworkException();
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        return OtherErrorException(
          message: 'Receive timeout in connection with API server'
        );
        break;
      case DioErrorType.SEND_TIMEOUT:
        return OtherErrorException(
          message: 'Send Timout in connection with API server'
        );
        break;
      default:
        return OtherErrorException(
          message: 'Unknown API Exception'
        );
    }
  }
}