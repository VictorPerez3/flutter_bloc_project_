import 'package:bloc_project_empiricus/data/models/info_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InfoModel Test', () {
    final json = {
      'name': 'nome',
      'shortDescription': 'descrição curta',
      'description': 'descrição',
      'imageSmall': 'imagem_pequena.jpg',
      'imageLarge': 'imagem_grande.jpg',
    };

    test('conversão json <-> objeto', () {
      final infoModel = InfoModel.fromJson(json);

      expect(infoModel.name, 'nome');
      expect(infoModel.shortDescription, 'descrição curta');
      expect(infoModel.description, 'descrição');
      expect(infoModel.imageSmall, 'imagem_pequena.jpg');
      expect(infoModel.imageLarge, 'imagem_grande.jpg');
    });
  });
}
