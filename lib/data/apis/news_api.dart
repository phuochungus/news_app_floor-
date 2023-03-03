import 'package:dio/dio.dart';
import 'package:news_app/local.dart';

class NewsAPI {
  static const String _endpoint =
      'https://newsapi.org/v2/everything?domains=wsj.com';
  static Future<List> getNewsOnPage(int page) async {
    try {
      var response = await Dio().get(_endpoint, queryParameters: {
        'apiKey': apiKey,
        'pageSize': 20,
        'page': 1,
      });
      List listOfObject = response.data['articles'] as List;
      return listOfObject;
    } catch (e) {
      rethrow;
    }
  }
}
