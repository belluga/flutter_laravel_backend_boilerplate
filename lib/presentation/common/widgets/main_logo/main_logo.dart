import 'package:belluga_boilerplate/infrastructure/repositories/app_data_repository.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/image_with_progress_indicator.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/main_logo/controllers/main_logo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value_builder.dart';

class MainLogo extends StatefulWidget {
  const MainLogo({super.key});

  @override
  State<MainLogo> createState() => _MainLogoState();
}

class _MainLogoState extends State<MainLogo> {
  final _controller = MainLogoController();

  @override
  Widget build(BuildContext context) {
    return StreamValueBuilder<ThemeData>(
        streamValue: _controller.themeDataStreamValue,
        builder: (context, themeData) {
          return ImageWithProgressIndicator(
            width: 90,
            height: 36,
            uri: getLogoUri(themeData),
            fit: BoxFit.contain,
          );
        });
  }

  Uri getLogoUri(ThemeData themeData) {
    final _brigthness = themeData.brightness;

    late String _logoPath;

    switch (_brigthness) {
      case Brightness.dark:
        _logoPath = "logo-dark.png";
        break;
      case Brightness.light:
        _logoPath = "logo-light.png";
        break;
    }

    final _appData = GetIt.I.get<AppDataRepository>().appData;

    return _appData.mainDomainValue.value.resolve(_logoPath);
  }
}
