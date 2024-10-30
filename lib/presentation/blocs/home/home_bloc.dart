import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/exceptions/custom_exceptions.dart';
import '../../../domain/repositories/info_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final InfoRepository repository;

  HomeBloc({required this.repository}) : super(HomeInitial()) {
    on<FetchAllInfoEvent>(_onFetchAllInfoEvent);
  }

  void _onFetchAllInfoEvent(
      FetchAllInfoEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final allInfo = await repository.fetchAllInfo();
      emit(HomeLoaded(allInfo: allInfo));
    } on NetworkException catch (e) {
      emit(HomeError(message: e.message));
    } on ServerException catch (e) {
      emit(HomeError(message: e.message));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
