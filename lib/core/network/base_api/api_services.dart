import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  
 static Future<dynamic> get(
    String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    VoidCallback? onError,
  ) async {

    Dio dio = Dio();

    debugPrint("hitting get request at $path🚀");

    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters ?? {},
        options: Options(headers: headers ?? {}),
      );
      debugPrint("got get request response✅ $response");

      return response.data;

    } catch (e) {
      onError;
    }
  }

 static Future<dynamic> post(
    String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    VoidCallback? onError,
     Map<String, dynamic> body
  ) async {

    Dio dio = Dio();
    debugPrint("hitting post request at $path🚀");

    try {
      final response = await dio.post(
        data: body,
        path,
        queryParameters: queryParameters ?? {},
        options: Options(headers: headers ?? {}),
      );
      debugPrint("got post request response✅ $response");

      return response.data;

    } catch (e) {
      onError;
    }
  }

 static Future<dynamic> patch(
    String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    VoidCallback? onError,
    Map<String, dynamic> body
  ) async {
    Dio dio = Dio();
    debugPrint("hitting patch request at $path🚀");

    try {
      final response = await dio.patch(
        data: body,
        path,
        queryParameters: queryParameters ?? {},
        options: Options(headers: headers ?? {}),
      );
      debugPrint("got patch request response✅ $response");
      
      return response.data;

    } catch (e) {
      onError;
    }
  }

 static Future<dynamic> delete(
    String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    VoidCallback? onError,
    Map<String, dynamic> body
  ) async {
    Dio dio = Dio();
    debugPrint("hitting delete request at $path🚀");

    try {
      final response = await dio.delete(
        data: body,
        path,
        queryParameters: queryParameters ?? {},
        options: Options(headers: headers ?? {}),
      );
      debugPrint("got delete request response✅ $response");
      
      return response.data;

    } catch (e) {
      onError;
    }
  }
}
