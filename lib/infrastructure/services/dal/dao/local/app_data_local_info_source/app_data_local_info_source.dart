export 'app_data_local_info_source_stub.dart'
    if (dart.library.html) 'app_data_local_info_source_web.dart'
    if (dart.library.io) 'app_data_local_info_source_mobile.dart';