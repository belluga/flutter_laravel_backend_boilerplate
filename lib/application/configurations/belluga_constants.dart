import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class BellugaConstants {
  static final settings = _SettingsConstants();
  static final api = _ApiConstants();
  static final sentry = _SentryConstants();
  static final env = _EnvironmentConstants();
}

class _ApiConstants {

  String get adminUrl {
    final String _mainApi = '${Uri.base.scheme}://${Uri.base.host}/admin/api';

    final _environment = BellugaConstants.env.environment;

    if (kIsWeb) {
      return _mainApi;
    } else if (Platform.isAndroid) {
      return _environment == "local"
          ? "http://nginx/api"
          : _mainApi;
    } else {
      return _mainApi;
    }
  }

  String get baseUrl {
    final String _mainApi = '${Uri.base.scheme}://${Uri.base.host}/api';

    final _environment = BellugaConstants.env.environment;

    if (kIsWeb) {
      return _mainApi;
    } else if (Platform.isAndroid) {
      return _environment == "local"
          ? "http://nginx/api"
          : _mainApi;
    } else {
      return _mainApi;
    }
  }
}

class _EnvironmentConstants {
  String get environment =>
      const String.fromEnvironment('APP_ENVIRONMENT', defaultValue: 'local');
  String get landlordDomain =>
      const String.fromEnvironment('LANDLORD_DOMAIN', defaultValue: 'localhost');
  String get schema =>
      const String.fromEnvironment('LANDLORD_SCHEMA', defaultValue: 'http');
  String get bootstrapBaseUrl => const String.fromEnvironment(
    'BOOTSTRAP_BASE_URL',
    defaultValue: '',
  );
}

class _SettingsConstants {
  String get platform {
    if (kIsWeb) {
      return "web";
    } else if (Platform.isAndroid) {
      return "android";
    } else if (Platform.isIOS) {
      return "ios";
    } else if (Platform.isWindows) {
      return "windows";
    } else if (Platform.isMacOS) {
      return "macos";
    } else if (Platform.isLinux) {
      return "linux";
    } else {
      return "unknown";
    }
  }
}

class _SentryConstants {
  String get url => const String.fromEnvironment('SENTRY_DSN', defaultValue: '');
  double get tracesSampleRate {
    const raw = String.fromEnvironment(
      'SENTRY_TRACES_SAMPLE_RATE',
      defaultValue: '0.0',
    );
    return double.tryParse(raw) ?? 0.0;
  }
}

// class AssetsPath {
//   static String mainLogo  = "assets/images/dark-logo.png";
//   static String productPlaceholder = "assets/images/product_placeholder.png";
//   static String plainIcon = "assets/images/plain_icon.png";
//   static String adaptiveIcon = "assets/images/adaptive_icon.png";
//   static String productImagePlaceholder = "assets/images/product_placeholder.png";
// }

// class Animations {
//   static const _animations = 'assets/animations';
//   static const logo = '$_animations/logo-animation.json';
// }
