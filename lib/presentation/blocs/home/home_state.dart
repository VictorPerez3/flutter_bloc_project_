import '../../../domain/entities/info.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Info> allInfo;

  HomeLoaded({required this.allInfo});
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
