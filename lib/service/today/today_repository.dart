import 'package:haengunse/service/today/today_api.dart';

class TodayRepository {
  static Future<Map<String, dynamic>> fetchToday(
      Map<String, dynamic> payload) async {
    return await TodayApi.fetchTodayData(payload);
  }
}
