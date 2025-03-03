part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeInitStreamEvent extends HomeEvent {}

class HomeLoadMoreArticlesEvent extends HomeEvent {
  final bool force;

  HomeLoadMoreArticlesEvent({this.force = false});
}
