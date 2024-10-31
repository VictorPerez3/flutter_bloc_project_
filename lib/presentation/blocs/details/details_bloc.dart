import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/exceptions/custom_exceptions.dart';
import '../../../domain/repositories/info_repository.dart';
import 'details_event.dart';
import 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final InfoRepository repository;

  DetailsBloc({required this.repository}) : super(DetailsInitial()) {
    on<FetchInfoByIdEvent>(_onFetchInfoByIdEvent);
  }

  void _onFetchInfoByIdEvent(
      FetchInfoByIdEvent event, Emitter<DetailsState> emit) async {
    emit(DetailsLoading());
    try {
      final info = await repository.fetchInfoById(event.id);
      emit(DetailsLoaded(info: info));
    } on NetworkException catch (e) {
      emit(DetailsError(message: e.message));
    } on ServerException catch (e) {
      emit(DetailsError(message: e.message));
    } catch (e) {
      emit(DetailsError(message: e.toString()));
    }
  }
}
