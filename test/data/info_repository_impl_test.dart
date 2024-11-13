import 'dart:convert';

import 'package:bloc_project_empiricus/data/repositories/info_repository_impl.dart';
import 'package:bloc_project_empiricus/domain/exceptions/custom_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  group('InfoRepositoryImpl Test', () {
    late InfoRepositoryImpl repository;

    setUp(() {
      repository = InfoRepositoryImpl();
    });

    test('Analisando decodeResponse e parseInfoList', () {
      const responseJson = '''
      {
        "groups": [
          {
            "name": "nome",
            "shortDescription": "descrição curta",
            "description": "descrição",
            "imageSmall": "imagem_pequena.jpg",
            "imageLarge": "imagem_grande.jpg"
          }
        ]
      }
      ''';

      final response = http.Response.bytes(utf8.encode(responseJson), 200);
      final infoList = repository.parseInfoList(response);

      expect(infoList.length, 1);
      expect(infoList[0].name, 'nome');
    });

    test('Lançamento de NetworkException sobre SocketException', () async {
      try {
        await repository.fetchAllInfo();
      } catch (e) {
        expect(e, isA<NetworkException>());
      }
    });

    test('Lançamento ServerException em response status diferente de 200', () async {
      final repository = InfoRepositoryImpl();
      try {
        await repository.fetchAllInfo();
      } catch (e) {
        expect(e, isA<ServerException>());
      }
    });

    test('Retorna o índice correto para um ID valido', () {
      const id = '1';
      const listLength = 5;
      final index = repository.getIndexFromId(id, listLength);

      expect(index, 1);
    });

    test('Retorna o índice correto para um ID valido no limite', () {
      const id = '5';
      const listLength = 5;
      final index = repository.getIndexFromId(id, listLength);

      expect(index, 5);
    });

    test('Lança exception para ID abaixo do intervalo', () {
      const id = '-1';
      const listLength = 5;

      expect(
            () => repository.getIndexFromId(id, listLength),
        throwsA(isA<Exception>()),
      );
    });

    test('Lança exception para ID acima do intervalo', () {
      const id = '6';
      const listLength = 5;

      expect(
            () => repository.getIndexFromId(id, listLength),
        throwsA(isA<Exception>()),
      );
    });

    test('Lança exception para ID como string', () {
      const id = 'abc';
      const listLength = 5;

      expect(
            () => repository.getIndexFromId(id, listLength),
        throwsA(isA<Exception>()),
      );
    });
  });
}
