import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApiClient {
  final Dio dio;

  ApiClient({required this.dio});

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await dio.get(path, queryParameters: queryParameters);
  }
}
