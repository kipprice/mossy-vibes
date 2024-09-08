import 'package:flutter/cupertino.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter/foundation.dart' as flutter_config;

class WakelockService {
  // static WakelockPlus _wakelockService = WakelockPlus;
  // WakelockService._init();

  // /// Wrapper for the wakelock library, as the library currently crashes the
  // /// iOS version of the app
  // factory WakelockService() => _wakelockService;

  Future<void> enable() async {
    if (flutter_config.kIsWeb) {
      WidgetsFlutterBinding.ensureInitialized();
      await WakelockPlus.enable();
    }
  }

  Future<void> disable() async {
    if (flutter_config.kIsWeb) {
      WidgetsFlutterBinding.ensureInitialized();
      await WakelockPlus.disable();
    }
  }
}
