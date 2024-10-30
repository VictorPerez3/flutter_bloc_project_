import 'dart:convert';
import 'dart:io';
import 'package:bloc_project_empiricus/presentation/utils/constants/app_strings.dart';
import 'package:http/http.dart' as http;
import '../../domain/entities/info.dart';
import '../../domain/exceptions/custom_exceptions.dart';
import '../../domain/repositories/info_repository.dart';
import '../models/info_model.dart';

class InfoRepositoryImpl implements InfoRepository {
  static const String apiUrl = AppStrings.apiUrl;

  @override
  Future<List<Info>> fetchAllInfo() async {
    try {
      final response = await getDataFromApi(apiUrl);
      return parseInfoList(response);
    } on SocketException {
      throw NetworkException();
    } on HttpException {
      throw ServerException();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<http.Response> getDataFromApi(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw ServerException();
    }
    return response;
  }

  @override
  List<Info> parseInfoList(http.Response response) {
    final data = json.decode(utf8.decode(response.bodyBytes));
    final List<dynamic> allInfoJson = data['groups'];
    return allInfoJson.map((json) => InfoModel.fromJson(json)).toList();
  }
}
