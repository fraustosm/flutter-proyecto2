import 'package:dio/dio.dart';

class UnsplashService {
  final Dio _dio = Dio();

  static const String _baseUrl =
      'https://api.unsplash.com';

  static const String _accessKey =
      '17hsIENCdv0tpHOMStS4nZnf4Od-aU-GDFhidLS4hfU';

  
  
  Future<List<dynamic>> fetchPhotos({
  int page = 1,
}) async {
  final response = await _dio.get(
    '$_baseUrl/photos',
    queryParameters: {
      'client_id': _accessKey,
      'page': page,
      'per_page': 10,
    },
  );

  return response.data;
}

Future<List<dynamic>> searchPhotos({
  required String query,
  int page = 1,
}) async {
  final response = await _dio.get(
    '$_baseUrl/search/photos',
    queryParameters: {
      'client_id': _accessKey,
      'query': query,
      'page': page,
      'per_page': 10,
    },
  );

  return response.data['results'];
}
  
}