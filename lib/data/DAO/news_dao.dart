import 'package:floor/floor.dart';

import '../DTO/news.dart';

@dao
abstract class NewsDAO {
  @Query('SELECT * FROM News')
  Future<List<News>> retrieveAllNews();

  @insert
  Future<void> insertAllNews(List<News> newsGroup);

  @Query('DELETE FROM News')
  Future<void> clearAllNews();
}
