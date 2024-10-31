import '../entities/info.dart';

abstract class InfoRepository {
  Future<List<Info>> fetchAllInfo();

  Future<Info> fetchInfoById(String id);
}
