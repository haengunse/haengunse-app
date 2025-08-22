import 'package:flutter/foundation.dart';

class PlatformHelper {
  static bool get isWeb => kIsWeb;
  static bool get isMobile => !kIsWeb;
}