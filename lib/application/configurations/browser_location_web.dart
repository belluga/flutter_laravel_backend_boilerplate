import 'package:web/web.dart' as web;

String? currentBrowserPath() {
  final pathname = web.window.location.pathname;
  if (pathname.isEmpty) {
    return '/';
  }

  return '$pathname${web.window.location.search}';
}

String? initialBrowserPath() {
  final initialPath = web.document
      .querySelector('#initial-browser-path')
      ?.getAttribute('content');
  if (initialPath != null && initialPath.isNotEmpty) {
    return initialPath;
  }

  return currentBrowserPath();
}

bool replaceBrowserPath(String path) {
  web.window.location.replace(path);
  return true;
}
