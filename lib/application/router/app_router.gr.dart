// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:belluga_boilerplate/presentation/init/init_route.dart' as _i11;
import 'package:belluga_boilerplate/presentation/screens/event_item/screens/event_item_screen.dart'
    as _i7;
import 'package:belluga_boilerplate/presentation/screens/landlord/home_landlord/home_landlord_route.dart'
    as _i10;
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/auth_create_new_password_route.dart'
    as _i1;
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/auth_login_route.dart'
    as _i2;
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/recovery_password_route.dart'
    as _i14;
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/dashboard_route.dart'
    as _i6;
import 'package:belluga_boilerplate/presentation/screens/tenants/home_tenant/home_tenant_route.dart'
    as _i16;
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_enrollment/course_enrollment_route.dart'
    as _i3;
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_route.dart'
    as _i4;
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/courses_list_route.dart'
    as _i5;
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/fast_tracks_list_route.dart'
    as _i9;
import 'package:belluga_boilerplate/presentation/screens/tenants/menu/menu_route.dart'
    as _i17;
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/screens/notes_route.dart'
    as _i12;
import 'package:belluga_boilerplate/presentation/screens/tenants/profile/profile_route.dart'
    as _i13;
import 'package:belluga_boilerplate/presentation/screens/tenants/schedule/event_search_route.dart'
    as _i8;
import 'package:belluga_boilerplate/presentation/screens/tenants/schedule/schedule_route.dart'
    as _i15;
import 'package:flutter/cupertino.dart' as _i20;
import 'package:flutter/material.dart' as _i19;

/// generated route for
/// [_i1.AuthCreateNewPasswordRoute]
class AuthCreateNewPasswordRoute extends _i18.PageRouteInfo<void> {
  const AuthCreateNewPasswordRoute({List<_i18.PageRouteInfo>? children})
      : super(AuthCreateNewPasswordRoute.name, initialChildren: children);

  static const String name = 'AuthCreateNewPasswordRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthCreateNewPasswordRoute();
    },
  );
}

/// generated route for
/// [_i2.AuthLoginRoute]
class AuthLoginRoute extends _i18.PageRouteInfo<void> {
  const AuthLoginRoute({List<_i18.PageRouteInfo>? children})
      : super(AuthLoginRoute.name, initialChildren: children);

  static const String name = 'AuthLoginRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthLoginRoute();
    },
  );
}

/// generated route for
/// [_i3.CourseEnrollmentRoute]
class CourseEnrollmentRoute
    extends _i18.PageRouteInfo<CourseEnrollmentRouteArgs> {
  CourseEnrollmentRoute({
    _i19.Key? key,
    required String courseItemId,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          CourseEnrollmentRoute.name,
          args: CourseEnrollmentRouteArgs(key: key, courseItemId: courseItemId),
          rawPathParams: {'courseItemId': courseItemId},
          initialChildren: children,
        );

  static const String name = 'CourseEnrollmentRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<CourseEnrollmentRouteArgs>(
        orElse: () => CourseEnrollmentRouteArgs(
          courseItemId: pathParams.getString('courseItemId'),
        ),
      );
      return _i3.CourseEnrollmentRoute(
        key: args.key,
        courseItemId: args.courseItemId,
      );
    },
  );
}

class CourseEnrollmentRouteArgs {
  const CourseEnrollmentRouteArgs({this.key, required this.courseItemId});

  final _i19.Key? key;

  final String courseItemId;

  @override
  String toString() {
    return 'CourseEnrollmentRouteArgs{key: $key, courseItemId: $courseItemId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CourseEnrollmentRouteArgs) return false;
    return key == other.key && courseItemId == other.courseItemId;
  }

  @override
  int get hashCode => key.hashCode ^ courseItemId.hashCode;
}

/// generated route for
/// [_i4.CourseRoute]
class CourseRoute extends _i18.PageRouteInfo<CourseRouteArgs> {
  CourseRoute({
    _i20.Key? key,
    required String courseItemId,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          CourseRoute.name,
          args: CourseRouteArgs(key: key, courseItemId: courseItemId),
          rawPathParams: {'courseItemId': courseItemId},
          initialChildren: children,
        );

  static const String name = 'CourseRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<CourseRouteArgs>(
        orElse: () =>
            CourseRouteArgs(courseItemId: pathParams.getString('courseItemId')),
      );
      return _i4.CourseRoute(key: args.key, courseItemId: args.courseItemId);
    },
  );
}

class CourseRouteArgs {
  const CourseRouteArgs({this.key, required this.courseItemId});

  final _i20.Key? key;

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
/// [_i5.CoursesListRoute]
class CoursesListRoute extends _i18.PageRouteInfo<void> {
  const CoursesListRoute({List<_i18.PageRouteInfo>? children})
      : super(CoursesListRoute.name, initialChildren: children);

  static const String name = 'CoursesListRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i5.CoursesListRoute();
    },
  );
}

/// generated route for
/// [_i6.DashboardRoute]
class DashboardRoute extends _i18.PageRouteInfo<void> {
  const DashboardRoute({List<_i18.PageRouteInfo>? children})
      : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i6.DashboardRoute();
    },
  );
}

/// generated route for
/// [_i7.EventItemScreen]
class EventItemRoute extends _i18.PageRouteInfo<EventItemRouteArgs> {
  EventItemRoute({
    _i19.Key? key,
    required String eventId,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          EventItemRoute.name,
          args: EventItemRouteArgs(key: key, eventId: eventId),
          rawPathParams: {'event_id': eventId},
          initialChildren: children,
        );

  static const String name = 'EventItemRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EventItemRouteArgs>(
        orElse: () =>
            EventItemRouteArgs(eventId: pathParams.getString('event_id')),
      );
      return _i7.EventItemScreen(key: args.key, eventId: args.eventId);
    },
  );
}

class EventItemRouteArgs {
  const EventItemRouteArgs({this.key, required this.eventId});

  final _i19.Key? key;

  final String eventId;

  @override
  String toString() {
    return 'EventItemRouteArgs{key: $key, eventId: $eventId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EventItemRouteArgs) return false;
    return key == other.key && eventId == other.eventId;
  }

  @override
  int get hashCode => key.hashCode ^ eventId.hashCode;
}

/// generated route for
/// [_i8.EventSearchRoute]
class EventSearchRoute extends _i18.PageRouteInfo<EventSearchRouteArgs> {
  EventSearchRoute({
    _i20.Key? key,
    bool autoFocusSearchField = true,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          EventSearchRoute.name,
          args: EventSearchRouteArgs(
            key: key,
            autoFocusSearchField: autoFocusSearchField,
          ),
          initialChildren: children,
        );

  static const String name = 'EventSearchRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventSearchRouteArgs>(
        orElse: () => const EventSearchRouteArgs(),
      );
      return _i8.EventSearchRoute(
        key: args.key,
        autoFocusSearchField: args.autoFocusSearchField,
      );
    },
  );
}

class EventSearchRouteArgs {
  const EventSearchRouteArgs({this.key, this.autoFocusSearchField = true});

  final _i20.Key? key;

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
/// [_i9.FastTrackListRoute]
class FastTrackListRoute extends _i18.PageRouteInfo<void> {
  const FastTrackListRoute({List<_i18.PageRouteInfo>? children})
      : super(FastTrackListRoute.name, initialChildren: children);

  static const String name = 'FastTrackListRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i9.FastTrackListRoute();
    },
  );
}

/// generated route for
/// [_i10.HomeLandlordRoute]
class HomeLandlordRoute extends _i18.PageRouteInfo<void> {
  const HomeLandlordRoute({List<_i18.PageRouteInfo>? children})
      : super(HomeLandlordRoute.name, initialChildren: children);

  static const String name = 'HomeLandlordRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i10.HomeLandlordRoute();
    },
  );
}

/// generated route for
/// [_i11.InitRoute]
class InitRoute extends _i18.PageRouteInfo<void> {
  const InitRoute({List<_i18.PageRouteInfo>? children})
      : super(InitRoute.name, initialChildren: children);

  static const String name = 'InitRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i11.InitRoute();
    },
  );
}

/// generated route for
/// [_i12.NotesRoute]
class NotesRoute extends _i18.PageRouteInfo<void> {
  const NotesRoute({List<_i18.PageRouteInfo>? children})
      : super(NotesRoute.name, initialChildren: children);

  static const String name = 'NotesRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i12.NotesRoute();
    },
  );
}

/// generated route for
/// [_i13.ProfileRoute]
class ProfileRoute extends _i18.PageRouteInfo<void> {
  const ProfileRoute({List<_i18.PageRouteInfo>? children})
      : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i13.ProfileRoute();
    },
  );
}

/// generated route for
/// [_i14.RecoveryPasswordRoute]
class RecoveryPasswordRoute
    extends _i18.PageRouteInfo<RecoveryPasswordRouteArgs> {
  RecoveryPasswordRoute({
    _i20.Key? key,
    String? initialEmail,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          RecoveryPasswordRoute.name,
          args: RecoveryPasswordRouteArgs(key: key, initialEmail: initialEmail),
          initialChildren: children,
        );

  static const String name = 'RecoveryPasswordRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RecoveryPasswordRouteArgs>(
        orElse: () => const RecoveryPasswordRouteArgs(),
      );
      return _i14.RecoveryPasswordRoute(
        key: args.key,
        initialEmail: args.initialEmail,
      );
    },
  );
}

class RecoveryPasswordRouteArgs {
  const RecoveryPasswordRouteArgs({this.key, this.initialEmail});

  final _i20.Key? key;

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
/// [_i15.ScheduleRoute]
class ScheduleRoute extends _i18.PageRouteInfo<void> {
  const ScheduleRoute({List<_i18.PageRouteInfo>? children})
      : super(ScheduleRoute.name, initialChildren: children);

  static const String name = 'ScheduleRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i15.ScheduleRoute();
    },
  );
}

/// generated route for
/// [_i16.TenantHomeRoute]
class TenantHomeRoute extends _i18.PageRouteInfo<void> {
  const TenantHomeRoute({List<_i18.PageRouteInfo>? children})
      : super(TenantHomeRoute.name, initialChildren: children);

  static const String name = 'TenantHomeRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i16.TenantHomeRoute();
    },
  );
}

/// generated route for
/// [_i17.TenantMenuRoute]
class TenantMenuRoute extends _i18.PageRouteInfo<void> {
  const TenantMenuRoute({List<_i18.PageRouteInfo>? children})
      : super(TenantMenuRoute.name, initialChildren: children);

  static const String name = 'TenantMenuRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i17.TenantMenuRoute();
    },
  );
}
