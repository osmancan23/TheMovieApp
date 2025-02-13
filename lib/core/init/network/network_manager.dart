
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app/core/base/model/i_network_model.dart';
import 'package:the_movie_app/core/constants/app_constants.dart';

enum RequestType { get, post, put, delete }

class NetworkManager {
  NetworkManager._init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppConstants.apiKey}',
        },
      ),
    );
  }
  static NetworkManager? _instance;
  static NetworkManager get instance {
    _instance ??= NetworkManager._init();
    return _instance!;
  }

  late final Dio dio;

  Future<R?> send<T extends INetworkModel<T>, R>({
    required String path,
    required RequestType type,
    required T parseModel,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    try {
      Response<dynamic> response;

      switch (type) {
        case RequestType.get:
          response = await dio.get(path, queryParameters: queryParameters);
        case RequestType.post:
          response = await dio.post(path, data: data);
        case RequestType.put:
          response = await dio.put(path, data: data);
        case RequestType.delete:
          response = await dio.delete(path);
      }
      debugPrint(response.statusCode.toString());
      debugPrint(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is List) {
          final list =
              (response.data as List).map((json) => parseModel.fromJson(json as Map<String, dynamic>)).toList();
          return list as R;
        }

        if (response.data is Map<String, dynamic>) {
          return parseModel.fromJson(response.data as Map<String, dynamic>) as R;
        }
      }
      return null;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Bağlantı zaman aşımına uğradı');
      case DioExceptionType.sendTimeout:
        return Exception('İstek gönderme zaman aşımına uğradı');
      case DioExceptionType.receiveTimeout:
        return Exception('Yanıt alma zaman aşımına uğradı');
      case DioExceptionType.badResponse:
        return Exception('Sunucu hatası: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('İstek iptal edildi');
      default:
        return Exception('Bir hata oluştu: ${error.message}');
    }
  }
}
