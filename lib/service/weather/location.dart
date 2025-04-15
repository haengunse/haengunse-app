import 'package:geolocator/geolocator.dart';

class MyLocation {
  double latitude = 37.5665; // ✅ 기본값: 서울
  double longitude = 126.9780;

  Future<void> getMyCurrentLocation() async {
    print("📍 위치 요청 시작");

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("🛰 위치 서비스 상태: $serviceEnabled");

    if (!serviceEnabled) {
      print("❗ 위치 서비스 꺼짐 → 서울 기본값 사용");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    print("🔒 초기 권한 상태: $permission");

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("🔓 요청 후 권한 상태: $permission");

      if (permission == LocationPermission.denied) {
        print("❗ 권한 거부 → 서울 기본값 사용");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("❗ 권한 영구 거부 → 서울 기본값 사용");
      return;
    }

    print("✅ 권한 허용됨. 위치 가져오는 중...");
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude = position.latitude;
      longitude = position.longitude;
      print("📌 위치 도착: lat=$latitude, lon=$longitude");
    } catch (e) {
      print("❗ 위치 가져오기 실패 → 서울 기본값 사용: $e");
    }
  }
}
