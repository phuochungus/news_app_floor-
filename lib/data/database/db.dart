import 'dart:async';

import 'package:floor/floor.dart';
import 'package:news_app/data/DAO/news_dao.dart';
import 'package:news_app/data/DTO/news.dart';

import '../type_converters/datetime_converter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'db.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [News])
abstract class NewsDatabase extends FloorDatabase {
  NewsDAO get getNewsDAO;
}

Future<NewsDatabase> getAppDB() async {
  return await $FloorNewsDatabase.databaseBuilder('app_database.db').build();
}
