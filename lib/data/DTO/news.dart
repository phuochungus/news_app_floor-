import 'package:equatable/equatable.dart';

import 'package:floor/floor.dart';

@entity
class News extends Equatable {
  @PrimaryKey(autoGenerate: true)
  int? id;

  // @ColumnInfo(name: 'storyId')
  // final int storyId;

  @ColumnInfo(name: 'title')
  final String title;

  @ColumnInfo(name: 'summary')
  final String summary;

  @ColumnInfo(name: 'modifiedAt')
  final DateTime modifiedAt;

  @ColumnInfo(name: 'imageUrl')
  final String imageUrl;

  News({
    this.id,
    required this.title,
    required this.summary,
    required this.modifiedAt,
    required this.imageUrl,
  });

  News.fromNewsAPI(Map<String, dynamic> json)
      : title = json['title'],
        summary = json['description'],
        modifiedAt = DateTime.parse(json['publishedAt']),
        imageUrl = json['urlToImage'];

  News copyWith(
      {String? title,
      String? summary,
      DateTime? modifiedAt,
      String? imageUrl}) {
    return News(
      title: title ?? this.title,
      summary: summary ?? this.summary,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [title, summary, modifiedAt, imageUrl];
}
