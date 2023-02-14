import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchNewsFromAPI extends HomeScreenEvent {}

class RetrieveNewsFromInternalDb extends HomeScreenEvent {}
