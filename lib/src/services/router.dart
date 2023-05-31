import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mossy_vibes/src/widgets/screens/about_screen.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/exercise_screen.dart';
import 'package:mossy_vibes/src/widgets/screens/exercises/exercises_screen.dart';
import 'package:mossy_vibes/src/widgets/screens/settings/settings_screen.dart';

import '../widgets/screens/home_screen.dart';
import 'analytics_service.dart';

const homeRouteName = 'Home';
const settingsRouteName = 'Settings';
const aboutRouteName = 'About Mossy Vibes';
const allExercisesRouteName = 'All Exercises';
const exerciseRouteName = ':exerciseId';

/// The mossyRouter ensures we can navigate smoothly between the pages in the
/// application, using native defaults for navigation.
final mossyRouter = GoRouter(
  initialLocation: '/',
  observers: [MossyObserver()],
  routes: [
    GoRoute(
        name: homeRouteName,
        path: '/',
        builder: (context, state) => HomeScreen(),
        routes: [
          GoRoute(
              name: settingsRouteName,
              path: 'settings',
              builder: (context, state) => SettingsScreen()),
          GoRoute(
              name: aboutRouteName,
              path: 'about',
              builder: (context, state) => AboutScreen()),
          GoRoute(
              name: allExercisesRouteName,
              path: 'exercises',
              builder: (context, state) => ExercisesScreen(),
              routes: [
                GoRoute(
                    name: exerciseRouteName,
                    path: ':exerciseId',
                    builder: (context, state) => ExerciseScreen(
                          exerciseId: state.pathParameters['exerciseId'] ?? '',
                        ))
              ]),
        ]),
  ],
);

class MossyObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logRouteChange(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logRouteChange(route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logRouteChange(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      logRouteChange(newRoute);
    }
  }

  String _getRouteName(Route<dynamic>? route) {
    if (route == null) {
      return '';
    }

    String name = route.settings.name ?? '';
    if (name == ':exerciseId') {
      name = (route.settings.arguments! as Map<String, String>)['exerciseId']!;
    }
    return name;
  }

  void logRouteChange(Route<dynamic> route) {
    final toName = _getRouteName(route);

    switch (route.settings.name) {
      case exerciseRouteName:
        AnalyticsService()
            .track(AnalyticEventType.exerciseVisited, {'exerciseId': toName});
        break;

      case settingsRouteName:
        AnalyticsService().track(AnalyticEventType.settingsVisited);
        break;

      case aboutRouteName:
        AnalyticsService().track(AnalyticEventType.aboutVisited);
        break;

      default:
        break;
    }
  }
}
