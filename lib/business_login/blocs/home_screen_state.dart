import 'package:equatable/equatable.dart';

import '../../data/DTO/news.dart';

enum NewsStatus { initial, success, failure }

class HomeScreenState extends Equatable {
  const HomeScreenState({
    this.status = NewsStatus.initial,
    this.newsGroup = const <News>[],
    this.hasReachMax = false,
  });

  final NewsStatus status;
  final List<News> newsGroup;
  final bool hasReachMax;

  HomeScreenState copyWith(
      {NewsStatus? status, List<News>? newsGroup, bool? hasReachMax}) {
    return HomeScreenState(
      status: status ?? this.status,
      newsGroup: newsGroup ?? this.newsGroup,
      hasReachMax: hasReachMax ?? this.hasReachMax,
    );
  }

  @override
  List<Object?> get props => [status, newsGroup, hasReachMax];
}
