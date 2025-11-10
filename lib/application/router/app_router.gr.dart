// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:belluga_boilerplate/presentation/init/init_route.dart' as _i9;
import 'package:belluga_boilerplate/presentation/screens/landlord/home_landlord/home_landlord_route.dart'
    as _i8;
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/auth_create_new_password_route.dart'
    as _i1;
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/auth_login_route.dart'
    as _i2;
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/recovery_password_route.dart'
    as _i11;
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/dashboard_route.dart'
    as _i5;
import 'package:belluga_boilerplate/presentation/screens/tenants/home_tenant/home_tenant_route.dart'
    as _i13;
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_route.dart'
    as _i3;
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/courses_list_route.dart'
    as _i4;
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/fast_tracks_list_route.dart'
    as _i7;
import 'package:belluga_boilerplate/presentation/screens/tenants/menu/menu_route.dart'
    as _i14;
import 'package:belluga_boilerplate/presentation/screens/tenants/profile/profile_route.dart'
    as _i10;
import 'package:belluga_boilerplate/presentation/screens/tenants/schedule/event_search_route.dart'
    as _i6;
import 'package:belluga_boilerplate/presentation/screens/tenants/schedule/schedule_route.dart'
    as _i12;
import 'package:flutter/cupertino.dart' as _i16;

/// generated route for
/// [_i1.AuthCreateNewPasswordRoute]
class AuthCreateNewPasswordRoute extends _i15.PageRouteInfo<void> {
  const AuthCreateNewPasswordRoute({List<_i15.PageRouteInfo>? children})
      : super(AuthCreateNewPasswordRoute.name, initialChildren: children);

  static const String name = 'AuthCreateNewPasswordRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthCreateNewPasswordRoute();
    },
  );
}

/// generated route for
/// [_i2.AuthLoginRoute]
class AuthLoginRoute extends _i15.PageRouteInfo<void> {
  const AuthLoginRoute({List<_i15.PageRouteInfo>? children})
      : super(AuthLoginRoute.name, initialChildren: children);

  static const String name = 'AuthLoginRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthLoginRoute();
    },
  );
}

/// generated route for
/// [_i3.CourseRoute]
class CourseRoute extends _i15.PageRouteInfo<CourseRouteArgs> {
  CourseRoute({
    _i16.Key? key,
    required String courseItemId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          CourseRoute.name,
          args: CourseRouteArgs(key: key, courseItemId: courseItemId),
          rawPathParams: {'courseItemId': courseItemId},
          initialChildren: children,
        );

  static const String name = 'CourseRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<CourseRouteArgs>(
        orElse: () =>
            CourseRouteArgs(courseItemId: pathParams.getString('courseItemId')),
      );
      return _i3.CourseRoute(key: args.key, courseItemId: args.courseItemId);
    },
  );
}

class CourseRouteArgs {
  const CourseRouteArgs({this.key, required this.courseItemId});

  final _i16.Key? key;

  final String courseItemId;

  @override
  String toString() {
    return 'CourseRouteArgs{key: $key, courseItemId: $courseItemId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CourseRouteArgs) return false;
    return key == other.key && courseItemId == other.courseItemId;
  }

  @override
  int get hashCode => key.hashCode ^ courseItemId.hashCode;
}

/// generated route for
/// [_i4.CoursesListRoute]
class CoursesListRoute extends _i15.PageRouteInfo<void> {
  const CoursesListRoute({List<_i15.PageRouteInfo>? children})
      : super(CoursesListRoute.name, initialChildren: children);

  static const String name = 'CoursesListRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i4.CoursesListRoute();
    },
  );
}

/// generated route for
/// [_i5.DashboardRoute]
class DashboardRoute extends _i15.PageRouteInfo<void> {
  const DashboardRoute({List<_i15.PageRouteInfo>? children})
      : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i5.DashboardRoute();
    },
  );
}

/// generated route for
/// [_i6.EventSearchRoute]
class EventSearchRoute extends _i15.PageRouteInfo<EventSearchRouteArgs> {
  EventSearchRoute({
    _i16.Key? key,
    bool autoFocusSearchField = true,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          EventSearchRoute.name,
          args: EventSearchRouteArgs(
            key: key,
            autoFocusSearchField: autoFocusSearchField,
          ),
          initialChildren: children,
        );

  static const String name = 'EventSearchRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventSearchRouteArgs>(
        orElse: () => const EventSearchRouteArgs(),
      );
      return _i6.EventSearchRoute(
        key: args.key,
        autoFocusSearchField: args.autoFocusSearchField,
      );
    },
  );
}

class EventSearchRouteArgs {
  const EventSearchRouteArgs({this.key, this.autoFocusSearchField = true});

  final _i16.Key? key;

  final bool autoFocusSearchField;

  @override
  String toString() {
    return 'EventSearchRouteArgs{key: $key, autoFocusSearchField: $autoFocusSearchField}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EventSearchRouteArgs) return false;
    return key == other.key &&
        autoFocusSearchField == other.autoFocusSearchField;
  }

  @override
  int get hashCode => key.hashCode ^ autoFocusSearchField.hashCode;
}

/// generated route for
/// [_i7.FastTrackListRoute]
class FastTrackListRoute extends _i15.PageRouteInfo<void> {
  const FastTrackListRoute({List<_i15.PageRouteInfo>? children})
      : super(FastTrackListRoute.name, initialChildren: children);

  static const String name = 'FastTrackListRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i7.FastTrackListRoute();
    },
  );
}

/// generated route for
/// [_i8.HomeLandlordRoute]
class HomeLandlordRoute extends _i15.PageRouteInfo<void> {
  const HomeLandlordRoute({List<_i15.PageRouteInfo>? children})
      : super(HomeLandlordRoute.name, initialChildren: children);

  static const String name = 'HomeLandlordRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i8.HomeLandlordRoute();
    },
  );
}

/// generated route for
/// [_i9.InitRoute]
class InitRoute extends _i15.PageRouteInfo<void> {
  const InitRoute({List<_i15.PageRouteInfo>? children})
      : super(InitRoute.name, initialChildren: children);

  static const String name = 'InitRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i9.InitRoute();
    },
  );
}

/// generated route for
/// [_i10.ProfileRoute]
class ProfileRoute extends _i15.PageRouteInfo<void> {
  const ProfileRoute({List<_i15.PageRouteInfo>? children})
      : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i10.ProfileRoute();
    },
  );
}

/// generated route for
/// [_i11.RecoveryPasswordRoute]
class RecoveryPasswordRoute
    extends _i15.PageRouteInfo<RecoveryPasswordRouteArgs> {
  RecoveryPasswordRoute({
    _i16.Key? key,
    String? initialEmail,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          RecoveryPasswordRoute.name,
          args: RecoveryPasswordRouteArgs(key: key, initialEmail: initialEmail),
          initialChildren: children,
        );

  static const String name = 'RecoveryPasswordRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RecoveryPasswordRouteArgs>(
        orElse: () => const RecoveryPasswordRouteArgs(),
      );
      return _i11.RecoveryPasswordRoute(
        key: args.key,
        initialEmail: args.initialEmail,
      );
    },
  );
}

class RecoveryPasswordRouteArgs {
  const RecoveryPasswordRouteArgs({this.key, this.initialEmail});

  final _i16.Key? key;

  final String? initialEmail;

  @override
  String toString() {
    return 'RecoveryPasswordRouteArgs{key: $key, initialEmail: $initialEmail}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RecoveryPasswordRouteArgs) return false;
    return key == other.key && initialEmail == other.initialEmail;
  }

  @override
  int get hashCode => key.hashCode ^ initialEmail.hashCode;
}

/// generated route for
/// [_i12.ScheduleRoute]
class ScheduleRoute extends _i15.PageRouteInfo<void> {
  const ScheduleRoute({List<_i15.PageRouteInfo>? children})
      : super(ScheduleRoute.name, initialChildren: children);

  static const String name = 'ScheduleRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i12.ScheduleRoute();
    },
  );
}

/// generated route for
/// [_i13.TenantHomeRoute]
class TenantHomeRoute extends _i15.PageRouteInfo<void> {
  const TenantHomeRoute({List<_i15.PageRouteInfo>? children})
      : super(TenantHomeRoute.name, initialChildren: children);

  static const String name = 'TenantHomeRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i13.TenantHomeRoute();
    },
  );
}

/// generated route for
/// [_i14.TenantMenuRoute]
class TenantMenuRoute extends _i15.PageRouteInfo<void> {
  const TenantMenuRoute({List<_i15.PageRouteInfo>? children})
      : super(TenantMenuRoute.name, initialChildren: children);

  static const String name = 'TenantMenuRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i14.TenantMenuRoute();
    },
  );
}
