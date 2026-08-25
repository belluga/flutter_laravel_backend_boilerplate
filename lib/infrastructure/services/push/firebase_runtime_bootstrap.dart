import 'package:belluga_boilerplate/domain/app_data/app_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseRuntimeBootstrap {
  const FirebaseRuntimeBootstrap._();

  static Future<bool> initialize(AppData appData) async {
    if (Firebase.apps.isNotEmpty) {
      return true;
    }

    final settings = appData.firebaseSettings;
    if (settings == null) {
      debugPrint('[Push] Firebase settings missing; push runtime disabled.');
      return false;
    }

    final appId = _appId(settings, appData.platformType.value?.name);
    final apiKey = _string(settings['api_key'] ?? settings['apiKey']);
    final projectId = _string(settings['project_id'] ?? settings['projectId']);
    final senderId = _string(
      settings['messaging_sender_id'] ?? settings['messagingSenderId'],
    );
    if (appId == null ||
        apiKey == null ||
        projectId == null ||
        senderId == null) {
      debugPrint('[Push] Firebase settings incomplete; push runtime disabled.');
      return false;
    }

    try {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: apiKey,
          appId: appId,
          messagingSenderId: senderId,
          projectId: projectId,
          storageBucket: _string(
            settings['storage_bucket'] ?? settings['storageBucket'],
          ),
          authDomain:
              _string(settings['auth_domain'] ?? settings['authDomain']),
          measurementId: _string(
            settings['measurement_id'] ?? settings['measurementId'],
          ),
        ),
      );
      return true;
    } catch (error) {
      debugPrint('[Push] Firebase initialization unavailable: $error');
      return false;
    }
  }

  static String? _appId(Map<String, dynamic> settings, String? platform) {
    final normalizedPlatform = platform?.toLowerCase();
    final platformAppId = normalizedPlatform == 'android'
        ? settings['android_app_id'] ?? settings['androidAppId']
        : normalizedPlatform == 'ios'
            ? settings['ios_app_id'] ?? settings['iosAppId']
            : null;
    return _string(
      platformAppId ?? settings['app_id'] ?? settings['appId'],
    );
  }

  static String? _string(Object? value) {
    final resolved = value?.toString().trim();
    return resolved == null || resolved.isEmpty ? null : resolved;
  }
}
