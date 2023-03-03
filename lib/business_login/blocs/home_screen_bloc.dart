import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:news_app/data/database/db.dart';
import '../../data/repositories/news_repository.dart';
import './home_screen_event.dart';
import './home_screen_state.dart';
import '../../data/DTO/news.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc(this.newsRepository) : super(const HomeScreenState()) {
    on<FetchNewsFromAPI>(_onNewsFetching);
    on<RetrieveNewsFromInternalDb>(_onNewsRetrieving);
  }
  final NewsRepository newsRepository;
  int numberOfFetchedNewsInJSON = -1;
  static const int startPage = 0;
  int totalNumberOfPage = startPage;

  Future<void> _onNewsRetrieving(
      HomeScreenEvent event, Emitter<HomeScreenState> emit) async {
    if (state.status != NewsStatus.initial) return;
    try {
      print('news retrieving');
      var db = await getAppDB();

      List<News> fetchedNews = await db.getNewsDAO.retrieveAllNews();
      totalNumberOfPage = fetchedNews.length ~/ 20;
      if (fetchedNews.isEmpty) {
        emit(state.copyWith(status: NewsStatus.failure));
        return;
      }
      emit(state.copyWith(
          status: NewsStatus.success,
          newsGroup: List.of(state.newsGroup)..addAll(fetchedNews.toList()),
          hasReachMax: false));
    } catch (e) {
      emit(state.copyWith(status: NewsStatus.failure));
    }
  }

  Future<void> _onNewsFetching(
      HomeScreenEvent event, Emitter<HomeScreenState> emit) async {
    if (state.hasReachMax) return;
    if (state.status == NewsStatus.success ||
        state.status == NewsStatus.initial) {
      try {
        List<News> fetchedNews =
            await newsRepository.getNewsOnPage(totalNumberOfPage + 1);

        if (fetchedNews.isNotEmpty) {
          totalNumberOfPage++;
          var db = await getAppDB();
          db.getNewsDAO.clearAllNews();
          db.getNewsDAO.insertAllNews(fetchedNews);

          if (numberOfFetchedNewsInJSON == -1) {
            numberOfFetchedNewsInJSON = fetchedNews.length;
          }
          if (fetchedNews.length < numberOfFetchedNewsInJSON) {
            emit(state.copyWith(
                status: NewsStatus.success,
                newsGroup: List.of(state.newsGroup)..addAll(fetchedNews),
                hasReachMax: true));
          } else {
            emit(state.copyWith(
                status: NewsStatus.success,
                newsGroup: List.of(state.newsGroup)..addAll(fetchedNews),
                hasReachMax: false));
          }
        } else if (fetchedNews.isEmpty) {
          emit(state.copyWith(
            status: NewsStatus.success,
            hasReachMax: true,
          ));
        }
      } catch (e) {
        add(RetrieveNewsFromInternalDb());
      }
    }
  }
}
