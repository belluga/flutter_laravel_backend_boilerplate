import 'package:belluga_boilerplate/presentation/common/widgets/image_with_progress_indicator.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/main_logo/controllers/main_logo_controller.dart';
import 'package:flutter/material.dart';
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
    return StreamValueBuilder(
      streamValue: _controller.themeDataStreamValue,
      builder: (context, themeData) {
        return ImageWithProgressIndicator(
          width: 90,
          height: 36,
          uri: getLogoUri(),
        );
      }
    );
  }

  Uri getLogoUri() {
    // final Tenant? _tenant = GetIt.I.get<TenantRepositoryContract>().tenant;
    // final Landlord _landlord = GetIt.I.get<LandlordRepositoryContract>().landlord;

    return Uri.base.resolve("logo-light.png");
  }
}
