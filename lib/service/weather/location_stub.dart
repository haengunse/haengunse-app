// 플랫폼별 구현을 위한 stub 파일
class MyLocation {
  double? latitude;
  double? longitude;

  Future<void> getMyCurrentLocation() async {
    throw UnimplementedError('getMyCurrentLocation() has not been implemented.');
  }
}