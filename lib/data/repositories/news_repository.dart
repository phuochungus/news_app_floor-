import 'package:dio/dio.dart';
import '../DTO/news.dart';
import '../apis/news_api.dart';

class NewsRepository {
  Future<List<News>> getNewsOnPage(int page) async {
    try {
      List response = await NewsAPI.getNewsOnPage(page);
      List<News> newsGroup = response.map((e) => News.fromNewsAPI(e)).toList();

      return newsGroup;
    } on DioError catch (e) {
      throw Exception('call API failed');
    }
  }
}
