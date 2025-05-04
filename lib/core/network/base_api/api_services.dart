import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  Dio dio = Dio(
    BaseOptions(
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );

  Future<Response?> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    debugPrint("hitting get request at $path🚀");

    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters ?? {},
        options: Options(headers: headers ?? {}),
      );
      debugPrint("got get request response✅ $response");

      return response;
    } catch (e) {
      debugPrint("❌Error in get request ${e.toString()}");
      return null;
    }
  }

  Future<Response?> post({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    debugPrint("hitting post request at $path🚀");

    try {
      final response = await dio.post(
        path,
        data: body ?? {},
        queryParameters: queryParameters ?? {},
        options: Options(headers: headers ?? {}),
      );
      debugPrint("got post request response✅ $response");

      return response;
    } catch (e) {
      debugPrint("❌Error in post request ${e.toString()}");
      return null;
    }
  }

  Future<Response?> patch({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    debugPrint("hitting patch request at $path🚀");

    try {
      final response = await dio.patch(
        path,
        data: body ?? {},

        queryParameters: queryParameters ?? {},
        options: Options(headers: headers ?? {}),
      );
      debugPrint("got patch request response✅ $response");

      return response;
    } catch (e) {
      debugPrint("❌Error in patch request ${e.toString()}");
      return null;
    }
  }

  Future<Response?> delete({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    debugPrint("hitting delete request at $path🚀");

    try {
      final response = await dio.delete(
        path,
        data: body,
        queryParameters: queryParameters ?? {},
        options: Options(headers: headers ?? {}),
      );
      debugPrint("got delete request response✅ $response");

      return response;
    } catch (e) {
      debugPrint("❌Error in delete request ${e.toString()}");
      return null;
    }
  }
}
