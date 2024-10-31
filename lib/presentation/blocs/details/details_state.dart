import '../../../domain/entities/info.dart';

abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsLoaded extends DetailsState {
  final Info info;

  DetailsLoaded({required this.info});
}

class DetailsError extends DetailsState {
  final String message;

  DetailsError({required this.message});
}
