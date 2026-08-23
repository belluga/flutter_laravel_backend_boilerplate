import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/configurations/browser_location.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/domain/repositories/auth_repository_contract.dart';
import 'package:get_it/get_it.dart';

typedef BrowserPathReplacer = bool Function(String path);

class AuthRouteGuard extends AutoRouteGuard {
  AuthRouteGuard({BrowserPathReplacer? replaceBrowserPathFn})
      : _replaceBrowserPath = replaceBrowserPathFn ?? replaceBrowserPath;

  final _authRepository = GetIt.I.get<AuthRepositoryContract>();
  final BrowserPathReplacer _replaceBrowserPath;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_authRepository.isAuthorized) {
      resolver.next(true);
    } else {
      if (_replaceBrowserPath('/login')) {
        resolver.next(false);
        return;
      }

      resolver.redirectUntil(const AuthLoginRoute());
    }
  }
}
