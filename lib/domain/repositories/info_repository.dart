import 'package:http/http.dart' as http;
import '../entities/info.dart';

abstract class InfoRepository {
  Future<List<Info>> fetchAllInfo();

  Future<http.Response> getDataFromApi(String url);

  List<Info> parseInfoList(http.Response response);
}
