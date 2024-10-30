import '../../domain/entities/info.dart';

class InfoModel extends Info {
  InfoModel({
    required super.name,
    required super.shortDescription,
    required super.description,
    required super.imageSmall,
    required super.imageLarge,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      name: json['name'] as String,
      shortDescription: json['shortDescription'] as String,
      description: json['description'] as String,
      imageSmall: json['imageSmall'] as String,
      imageLarge: json['imageLarge'] as String,
    );
  }
}
