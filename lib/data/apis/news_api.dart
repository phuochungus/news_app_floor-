import 'package:dio/dio.dart';

class NewsAPI {
  final String _endpoint = 'http://3.91.70.32/intern/apis/news';
  Future<List> getNewsOnPage(int page) async {
    try {
      var response = await Dio()
          .get(_endpoint, queryParameters: {'page': page.toString()});
      List listOfObject = response.data as List;
      return listOfObject;
    } catch (e) {
      rethrow;
    }
  }
}
