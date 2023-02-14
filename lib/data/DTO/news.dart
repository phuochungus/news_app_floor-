import 'package:equatable/equatable.dart';

import 'package:floor/floor.dart';

@entity
class News extends Equatable {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'storyId')
  final int storyId;

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
    required this.storyId,
    required this.title,
    required this.summary,
    required this.modifiedAt,
    required this.imageUrl,
  });

  News.fromAPIMap(Map<String, dynamic> json)
      : storyId = json['storyId'],
        title = json['title'],
        summary = json['summary'],
        modifiedAt = DateTime.parse(json['modifiedAt']),
        imageUrl = json['image'];

  News copyWith(int storyId, String title, String summary, DateTime modifiedAt,
      String imageUrl) {
    return News(
        storyId: storyId,
        title: title,
        summary: summary,
        modifiedAt: modifiedAt,
        imageUrl: imageUrl);
  }

  @override
  List<Object?> get props => [storyId, title, summary, modifiedAt, imageUrl];
}
