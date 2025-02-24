import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> navigateTo(String routeName, {Object? arguments}) {
    final currentState = navigatorKey.currentState;
    if (currentState != null) {
      return currentState.pushNamed(routeName, arguments: arguments);
    } else {
      throw Exception('Navigator state is null. Cannot navigate to $routeName');
    }
  }

  void goBack() {
    final currentState = navigatorKey.currentState;
    if (currentState != null) {
      currentState.pop();
    } else {
      throw Exception('Navigator state is null. Cannot go back');
    }
  }
}

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();
  factory AppRouter() => _instance;
  AppRouter._internal();

  final NavigationService _navigationService = NavigationService();
  final Map<String, Widget Function(BuildContext, Object?)> _routes = {};

  NavigationService get navigationService => _navigationService;
  Widget? _pageNotFoundWidget;

  bool _isInitialized = false;

  void initializeRouter(
      Map<String, Widget Function(BuildContext, Object?)> routes,
      {Widget? pageNotFoundWidget}) {
    if (!_isInitialized) {
      _routes.addAll(routes);
      _isInitialized = true;
      _pageNotFoundWidget = pageNotFoundWidget;
    } else {
      debugPrint(
          'Router has already been initialized. Use addRoutes() to add more routes.');
    }
  }

  void addRoutes(Map<String, Widget Function(BuildContext, Object?)> routes) {
    _routes.addAll(routes);
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    if (!_isInitialized) {
      throw Exception(
          'Router has not been initialized. Call initializeRouter() first.');
    }

    // Extract the path without query parameters
    final uri = Uri.parse(settings.name ?? '');
    final routeBuilder = _routes[uri.path];

    if (routeBuilder != null) {
      return _buildPageRoute(settings, routeBuilder);
    }

    // Handle unknown routes
    return _buildPageRoute(
      settings,
      (context, _) => _pageNotFoundWidget ?? const Scaffold(
        body: Center(child: Text('404 - Page not found')),
      ),
    );
  }

  PageRouteBuilder<dynamic> _buildPageRoute(
    RouteSettings settings,
    Widget Function(BuildContext, Object?) builder,
  ) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) =>
          builder(context, settings.arguments),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return _buildTransition(animation, child);
      },
    );
  }

  Widget _buildTransition(Animation<double> animation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }

  Future<void> navigateTo(
    String routeName, {
    Object? arguments,
    Map<String, String> queryParams = const {},
  }) {
    if (queryParams.isNotEmpty) {
      final uri = Uri(path: routeName, queryParameters: queryParams);
      routeName = uri.toString();
    }
    return _navigationService.navigateTo(routeName, arguments: arguments);
  }

  void goBack() => _navigationService.goBack();

  String getCurrentPath(BuildContext? context) {
    String currentRoute = '/';
    if (context == null) return currentRoute;
    currentRoute =  ModalRoute.of(context)?.settings.name ?? currentRoute;
    return currentRoute;
  }

  void updateUrl(String path, {Object? arguments}) {
    final currentState = _navigationService.navigatorKey.currentState;
    if (currentState != null) {
      currentState.pushReplacementNamed(path, arguments: arguments);
    } else {
      throw Exception('Navigator state is null. Cannot update URL to $path');
    }
  }
}

// Extension method for easy access to AppRouter
extension AppRouterExtension on BuildContext {
  AppRouter get router => AppRouter();
}
