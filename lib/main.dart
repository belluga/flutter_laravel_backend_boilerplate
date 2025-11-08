import 'package:belluga_boilerplate/application/application.dart';
import 'package:belluga_boilerplate/application/application_contract.dart';
import 'package:belluga_boilerplate/application/configurations/belluga_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = BellugaConstants.sentry.url;
      options.tracesSampleRate = BellugaConstants.sentry.tracesSampleRate;
    },
    appRunner: () async {
      GetIt.I.registerSingleton<ApplicationContract>(Application());

      final application = GetIt.I.get<ApplicationContract>();
      await application.init();

      runApp(application);
    },
  );
}

// void _initApp() {
  






  
//   runApp(
//     Application(
        // pushHandler: _pushHandler,
        // authRepository: _authRepository,
        // bellugaApp: _bellugaApp,
//         ),
//   );
// }

// Future<void> _onBackgroundMessage(message) async =>
//     await PushHandler.onBackgroundMessage(message);
