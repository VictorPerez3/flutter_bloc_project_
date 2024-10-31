import 'dart:convert';
import 'dart:io';
import 'dart:math';
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
      final response = await _getDataFromApi(apiUrl);
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
  Future<Info> fetchInfoById(String id) async {
    try {
      final response = await _getDataFromApi(apiUrl);
      final data = _decodeResponse(response);
      final index = getIndexFromId(id, data['groups'].length);

      return InfoModel.fromJson(data['groups'][index]);
    } on SocketException {
      throw NetworkException();
    } on HttpException {
      throw ServerException();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> _getDataFromApi(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) throw ServerException();
    return response;
  }

  Map<String, dynamic> _decodeResponse(http.Response response) {
    return json.decode(utf8.decode(response.bodyBytes));
  }

  int getIndexFromId(String id, int listLength) {
    final index = int.tryParse(id) ?? -1;
    if (index < 1 || index > listLength) {
      throw Exception(AppStrings.idNotFoundExceptionMessage);
    }
    return index - 1;
  }

  List<Info> parseInfoList(http.Response response) {
    final data = _decodeResponse(response);
    final List<dynamic> allInfoJson = data['groups'];
    return allInfoJson.map((json) => InfoModel.fromJson(json)).toList();
  }
}
