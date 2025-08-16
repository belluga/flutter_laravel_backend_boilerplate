// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:belluga_now/presentation/init/init_screen.dart' as _i3;
import 'package:belluga_now/presentation/screens/auth/create_new_password/auth_create_new_password.dart'
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/foundation.dart' as _i13;
import 'package:unifast_portal/presentation/init/init_screen.dart' as _i8;
import 'package:unifast_portal/presentation/screens/auth/create_new_password/auth_create_new_password.dart'
    as _i1;
import 'package:belluga_now/presentation/screens/auth/login/auth_login_screen.dart'
    as _i2;
import 'package:belluga_now/presentation/screens/auth/recovery_password_bug/recovery_password_screen.dart'
    as _i6;
import 'package:belluga_now/presentation/screens/home_landlord/landlord_home_screen.dart'
    as _i4;
import 'package:belluga_now/presentation/screens/home_tenant/tenant_home_screen.dart'
    as _i7;
import 'package:belluga_now/presentation/screens/profile/profile_screen.dart'
    as _i5;
import 'package:flutter/material.dart' as _i9;
import 'package:unifast_portal/presentation/screens/home/home_screen.dart'
    as _i7;
import 'package:unifast_portal/presentation/screens/lms/screens/course_screen/course_screen.dart'
    as _i3;
import 'package:unifast_portal/presentation/screens/lms/screens/courses_list_screen/courses_list_screen.dart'
    as _i4;
import 'package:unifast_portal/presentation/screens/lms/screens/fast_tracks_list_screen/fast_tracks_list_screen.dart'
    as _i6;
import 'package:unifast_portal/presentation/screens/profile/profile_screen.dart'
    as _i9;
import 'package:unifast_portal/presentation/screens/schedule/screens/schedule_screen.dart'
    as _i11;

/// generated route for
/// [_i1.AuthCreateNewPasswordScreen]
class AuthCreateNewPasswordRoute extends _i8.PageRouteInfo<void> {
  const AuthCreateNewPasswordRoute({List<_i8.PageRouteInfo>? children})
      : super(AuthCreateNewPasswordRoute.name, initialChildren: children);
class AuthCreateNewPasswordRoute extends _i12.PageRouteInfo<void> {
  const AuthCreateNewPasswordRoute({List<_i12.PageRouteInfo>? children})
    : super(AuthCreateNewPasswordRoute.name, initialChildren: children);

  static const String name = 'AuthCreateNewPasswordRoute';

  static _i8.PageInfo page = _i8.PageInfo(
  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthCreateNewPasswordScreen();
    },
  );
}

/// generated route for
/// [_i2.AuthLoginScreen]
class AuthLoginRoute extends _i8.PageRouteInfo<void> {
  const AuthLoginRoute({List<_i8.PageRouteInfo>? children})
      : super(AuthLoginRoute.name, initialChildren: children);
class AuthLoginRoute extends _i12.PageRouteInfo<void> {
  const AuthLoginRoute({List<_i12.PageRouteInfo>? children})
    : super(AuthLoginRoute.name, initialChildren: children);

  static const String name = 'AuthLoginRoute';

  static _i8.PageInfo page = _i8.PageInfo(
  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthLoginScreen();
    },
  );
}

/// generated route for
/// [_i3.InitScreen]
class InitRoute extends _i8.PageRouteInfo<void> {
  const InitRoute({List<_i8.PageRouteInfo>? children})
      : super(InitRoute.name, initialChildren: children);
/// [_i3.CourseScreen]
class CourseRoute extends _i12.PageRouteInfo<CourseRouteArgs> {
  CourseRoute({
    _i13.Key? key,
    required String courseItemId,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         CourseRoute.name,
         args: CourseRouteArgs(key: key, courseItemId: courseItemId),
         rawPathParams: {'courseItemId': courseItemId},
         initialChildren: children,
       );

  static const String name = 'InitRoute';

  static _i8.PageInfo page = _i8.PageInfo(
  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i3.InitScreen();
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<CourseRouteArgs>(
        orElse: () =>
            CourseRouteArgs(courseItemId: pathParams.getString('courseItemId')),
      );
      return _i3.CourseScreen(key: args.key, courseItemId: args.courseItemId);
    },
  );
}

class CourseRouteArgs {
  const CourseRouteArgs({this.key, required this.courseItemId});

  final _i13.Key? key;

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
/// [_i4.CoursesListScreen]
class CoursesListRoute extends _i12.PageRouteInfo<void> {
  const CoursesListRoute({List<_i12.PageRouteInfo>? children})
    : super(CoursesListRoute.name, initialChildren: children);

  static const String name = 'CoursesListRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.CoursesListScreen();
    },
  );
}

/// generated route for
/// [_i4.LandlordHomeScreen]
class LandlordHomeRoute extends _i8.PageRouteInfo<void> {
  const LandlordHomeRoute({List<_i8.PageRouteInfo>? children})
      : super(LandlordHomeRoute.name, initialChildren: children);
/// [_i5.DashboardScreen]
class DashboardRoute extends _i12.PageRouteInfo<void> {
  const DashboardRoute({List<_i12.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'LandlordHomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.LandlordHomeScreen();
    },
  );
}

/// generated route for
/// [_i5.ProfileScreen]
class ProfileRoute extends _i8.PageRouteInfo<void> {
  const ProfileRoute({List<_i8.PageRouteInfo>? children})
      : super(ProfileRoute.name, initialChildren: children);
/// [_i6.FastTrackListScreen]
class FastTrackListRoute extends _i12.PageRouteInfo<void> {
  const FastTrackListRoute({List<_i12.PageRouteInfo>? children})
    : super(FastTrackListRoute.name, initialChildren: children);

  static const String name = 'FastTrackListRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i6.FastTrackListScreen();
    },
  );
}

/// generated route for
/// [_i7.HomeScreen]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomeScreen();
    },
  );
}

/// generated route for
/// [_i8.InitScreen]
class InitRoute extends _i12.PageRouteInfo<void> {
  const InitRoute({List<_i12.PageRouteInfo>? children})
    : super(InitRoute.name, initialChildren: children);

  static const String name = 'InitRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i8.InitScreen();
    },
  );
}

/// generated route for
/// [_i9.ProfileScreen]
class ProfileRoute extends _i12.PageRouteInfo<void> {
  const ProfileRoute({List<_i12.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i8.PageInfo page = _i8.PageInfo(
  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i6.RecoveryPasswordScreen]
class RecoveryPasswordRoute
    extends _i8.PageRouteInfo<RecoveryPasswordRouteArgs> {
    extends _i12.PageRouteInfo<RecoveryPasswordRouteArgs> {
  RecoveryPasswordRoute({
    _i9.Key? key,
    _i13.Key? key,
    String? initialEmmail,
    List<_i8.PageRouteInfo>? children,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          RecoveryPasswordRoute.name,
          args: RecoveryPasswordRouteArgs(
            key: key,
            initialEmmail: initialEmmail,
          ),
          initialChildren: children,
        );

  static const String name = 'RecoveryPasswordRoute';

  static _i8.PageInfo page = _i8.PageInfo(
  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RecoveryPasswordRouteArgs>(
        orElse: () => const RecoveryPasswordRouteArgs(),
      );
      return _i6.RecoveryPasswordScreen(
        key: args.key,
        initialEmmail: args.initialEmmail,
      );
    },
  );
}

class RecoveryPasswordRouteArgs {
  const RecoveryPasswordRouteArgs({this.key, this.initialEmmail});

  final _i9.Key? key;
  final _i13.Key? key;

  final String? initialEmmail;

  @override
  String toString() {
    return 'RecoveryPasswordRouteArgs{key: $key, initialEmmail: $initialEmmail}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RecoveryPasswordRouteArgs) return false;
    return key == other.key && initialEmmail == other.initialEmmail;
  }

  @override
  int get hashCode => key.hashCode ^ initialEmmail.hashCode;
}

/// generated route for
/// [_i7.TenantHomeScreen]
class TenantHomeRoute extends _i8.PageRouteInfo<void> {
  const TenantHomeRoute({List<_i8.PageRouteInfo>? children})
      : super(TenantHomeRoute.name, initialChildren: children);

  static const String name = 'TenantHomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.TenantHomeScreen();
    },
  );
}

/// generated route for
/// [_i11.ScheduleScreen]
class ScheduleRoute extends _i12.PageRouteInfo<void> {
  const ScheduleRoute({List<_i12.PageRouteInfo>? children})
    : super(ScheduleRoute.name, initialChildren: children);

  static const String name = 'ScheduleRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.ScheduleScreen();
    },
  );
}
