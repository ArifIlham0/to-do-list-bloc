import 'package:dio/dio.dart' as dio;
import 'package:todolist_bloc/common/helpers/user_preferences.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';
import 'package:todolist_bloc/core/constants/api.dart';
import 'package:todolist_bloc/presentation/export_pages.dart';
import 'interceptors.dart';

class DioClient {
  late final dio.Dio _dio;
  final _storageHelper = StorageHelper();

  DioClient()
      : _dio = dio.Dio(
          dio.BaseOptions(
            baseUrl: Api.baseURL,
            headers: headersNoToken,
            responseType: dio.ResponseType.json,
            sendTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ),
        ) {
    _dio.interceptors.addAll([
      LoggerInterceptor(onUnauthorized: () async {
        customSnackbar("Sesi login habis, silahkan login kembali", color: kRed);
        await _storageHelper.clear();
        customNavigation(() => const LoginPage());
      })
    ]);
  }
  
  Future<Map<String, String>> _getHeaders({bool isMultipart = false}) async {
    final token = await _storageHelper.getString("token");

    if (isMultipart) {
      if (token != null) {
        return headersFormDataWithToken(token);
      }
      return headersFormDataNoToken;
    } else {
      if (token != null) {
        return headersWithToken(token);
      }
      return headersNoToken;
    }
  }

  Future<dio.Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    dio.ProgressCallback? onReceiveProgress,
    bool isMultipart = false,
  }) async {
    final headers = await _getHeaders(isMultipart: isMultipart);
    final mergedOptions = (options ?? dio.Options()).copyWith(headers: headers);

    try {
      final dio.Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: mergedOptions,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on dio.DioException {
      rethrow;
    }
  }

  Future<dio.Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.ProgressCallback? onSendProgress,
    dio.ProgressCallback? onReceiveProgress,
    bool isMultipart = false,
  }) async {
    final headers = await _getHeaders(isMultipart: isMultipart);
    final mergedOptions = (options ?? dio.Options()).copyWith(headers: headers);

    try {
      final dio.Response response = await _dio.post(
        url,
        data: data,
        options: mergedOptions,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dio.Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    dio.ProgressCallback? onSendProgress,
    dio.ProgressCallback? onReceiveProgress,
    bool isMultipart = false,
  }) async {
    final headers = await _getHeaders(isMultipart: isMultipart);
    final mergedOptions = (options ?? dio.Options()).copyWith(headers: headers);

    try {
      final dio.Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: mergedOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    bool isMultipart = false,
  }) async {
    final headers = await _getHeaders(isMultipart: isMultipart);
    final mergedOptions = (options ?? dio.Options()).copyWith(headers: headers);

    try {
      final dio.Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: mergedOptions,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}