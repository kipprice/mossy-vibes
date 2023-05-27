import 'package:go_router/go_router.dart';
import 'package:mossy_vibes/src/widgets/screens/about_screen.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/exercise_screen.dart';
import 'package:mossy_vibes/src/widgets/screens/exercises/exercises_screen.dart';
import 'package:mossy_vibes/src/widgets/screens/settings/settings_screen.dart';

import '../widgets/screens/home_screen.dart';

/// The mossyRouter ensures we can navigate smoothly between the pages in the
/// application, using native defaults for navigation.
final mossyRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen(), routes: [
      GoRoute(path: 'settings', builder: (context, state) => SettingsScreen()),
      GoRoute(path: 'about', builder: (context, state) => AboutScreen()),
      GoRoute(
          path: 'exercises',
          builder: (context, state) => ExercisesScreen(),
          routes: [
            GoRoute(
                path: ':exerciseId',
                builder: (context, state) => ExerciseScreen(
                      exerciseId: state.pathParameters['exerciseId'] ?? '',
                    ))
          ]),
    ]),
  ],
);
