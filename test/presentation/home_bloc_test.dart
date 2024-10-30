import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_project_empiricus/presentation/blocs/home/home_bloc.dart';
import 'package:bloc_project_empiricus/presentation/blocs/home/home_event.dart';
import 'package:bloc_project_empiricus/presentation/blocs/home/home_state.dart';
import 'package:bloc_project_empiricus/domain/entities/info.dart';
import 'package:bloc_project_empiricus/domain/repositories/info_repository.dart';

class FakeInfoRepository implements InfoRepository {
  @override
  Future<List<Info>> fetchAllInfo() async {
    return [
      Info(
        name: 'nome',
        shortDescription: 'descrição curta',
        description: 'descrição',
        imageSmall: 'imagem_pequena.jpg',
        imageLarge: 'imagem_grande.jpg',
      ),
    ];
  }

  @override
  Future<http.Response> getDataFromApi(String url) async {
    throw UnimplementedError();
  }

  @override
  List<Info> parseInfoList(http.Response response) {
    throw UnimplementedError();
  }
}

void main() {
  group('HomeBloc Test', () {
    late HomeBloc homeBloc;
    late FakeInfoRepository fakeInfoRepository;

    setUp(() {
      fakeInfoRepository = FakeInfoRepository();
      homeBloc = HomeBloc(repository: fakeInfoRepository);
    });

    tearDown(() {
      homeBloc.close();
    });

    test('Emite estado inicial HomeInitial', () {
      expect(homeBloc.state, isA<HomeInitial>());
    });

    test('Emite HomeLoading e HomeLoaded após FetchAllInfoEvent', () async {
      homeBloc.add(FetchAllInfoEvent());

      await expectLater(
        homeBloc.stream,
        emitsInOrder([
          isA<HomeLoading>(),
          isA<HomeLoaded>()
              .having((state) => state.allInfo.length, 'allInfo length', 1),
        ]),
      );
    });
  });
}
