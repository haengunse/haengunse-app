import 'package:haengunse/service/manse/manse_api.dart';

class ManseRepository {
  static Future<bool> sendManse(Map<String, dynamic> payload) async {
    return await ManseApiService().sendManseData(payload);
  }
}
