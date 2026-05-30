import 'package:dio/dio.dart';

class UnsplashService {
  final Dio _dio = Dio();

  static const String _baseUrl =
      'https://api.unsplash.com';

  static const String _accessKey =
      '17hsIENCdv0tpHOMStS4nZnf4Od-aU-GDFhidLS4hfU';

  Future<List<dynamic>> fetchPhotos() async {
    final response = await _dio.get(
      '$_baseUrl/photos',
      queryParameters: {
        'client_id': _accessKey,
        'per_page': 20,
      },
    );

    return response.data;
  }
}