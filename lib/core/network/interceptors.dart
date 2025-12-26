import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

typedef OnUnauthorized = void Function();
class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true));
  LoggerInterceptor({this.onUnauthorized});
  final OnUnauthorized? onUnauthorized;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    String fullUrl = requestPath;
    if (options.queryParameters.isNotEmpty) {
      final queryString = options.queryParameters.entries.map((entry) => "${entry.key}=${entry.value}").join("&");
      fullUrl = "$requestPath?$queryString";
    }
    logger.e('${options.method} request ==> $fullUrl');
    if (options.data != null) {
      logger.e('REQUEST BODY: ${formatRequestBody(options.data)}');
    }
    logger.d('Error type: ${err.error} \n '
        'Error message: ${err.message}');
    if (err.response?.statusCode == 401) {
      onUnauthorized?.call();
    }
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    String fullUrl = requestPath;
    if (options.queryParameters.isNotEmpty) {
      final queryString = options.queryParameters.entries.map((entry) => "${entry.key}=${entry.value}").join("&");
      fullUrl = "$requestPath?$queryString";
    }
    logger.i('${options.method} request ==> $fullUrl');
    if (options.headers.isNotEmpty) {
      logger.i('REQUEST HEADERS: ${options.headers}');
    }
    if (options.data != null) {
      logger.i('REQUEST BODY: ${formatRequestBody(options.data)}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('STATUSCODE: ${response.statusCode} \n '
        'STATUSMESSAGE: ${response.statusMessage} \n'
        'HEADERS: ${response.headers} \n'
        'Data: ${response.data}');
    handler.next(response);
  }

  String formatRequestBody(dynamic data) {
    try {
      if (data is FormData) {
        final fields = data.fields.map((field) => '${field.key}: ${field.value}').join(', ');
        final files = data.files.map((file) => '${file.key}: ${file.value.filename ?? 'file'}').join(', ');
        return 'FormData - Fields: [$fields], Files: [$files]';
      } else if (data is Map || data is List) {
        return const JsonEncoder.withIndent('  ').convert(data);
      } else if (data is String) {
        try {
          final decoded = jsonDecode(data);
          return const JsonEncoder.withIndent('  ').convert(decoded);
        } catch (_) {
          return data;
        }
      } else {
        return data.toString();
      }
    } catch (e) {
      return 'Error formatting request body: $e';
    }
  }
}