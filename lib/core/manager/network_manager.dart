import 'package:dio/dio.dart';

class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager? get instance {
    _instance ??= NetworkManager._init();
    return _instance;
  }

  late Dio dio;

  NetworkManager._init() {
    final baseOptions = BaseOptions(
      baseUrl: 'https://api.nasa.gov/mars-photos/api/v1/rovers/',
    );

    dio = Dio(baseOptions);
  }
}
