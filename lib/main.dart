import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/models/exercise.dart';
import 'package:mossy_vibes/src/services/exercise_loader.dart';
import 'package:mossy_vibes/src/services/exercise_parser.dart';
import 'package:mossy_vibes/src/services/preferences_loader.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'src/models/preferences.dart';
import 'src/services/router.dart';
import 'src/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  // initializeApp();
  runApp(MossyVibes());
}

Future<void> initializeApp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MossyVibes extends StatefulWidget {
  /// Mossy Vibes is a simple, reading-based meditation app built with Flutter.
  ///
  /// It does very little server communication, only refreshing the available
  /// meditations when the user loads the app when they are online. This is
  /// purposeful, to keep the
  const MossyVibes({super.key});

  @override
  State<MossyVibes> createState() => _MossyVibesState();
}

class _MossyVibesState extends State<MossyVibes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MossyVibesState(DefaultAssetBundle.of(context)),
      child: MaterialApp.router(
        routerConfig: mossyRouter,
        title: 'Mossy Vibes',
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Quicksand',
            colorScheme: ColorScheme(
                background: MossyColors.darkGreen,
                onBackground: MossyColors.offWhite,
                primary: MossyColors.lightGreen,
                onPrimary: MossyColors.offBlack,
                secondary: MossyColors.lightOrange,
                onSecondary: MossyColors.darkBrown,
                brightness: Brightness.dark,
                error: MossyColors.yellow,
                onError: MossyColors.offBlack,
                surface: Colors.transparent,
                onSurface: MossyColors.offBlack)

            // ColorScheme.fromSeed(seedColor: Color(0xFF136F63)),
            ),
      ),
    );
  }
}

enum MossyStatus { loading, ready, error, uninitialized }

class MossyVibesState extends ChangeNotifier {
  MossyStatus status = MossyStatus.uninitialized;
  UserPreferences preferences = UserPreferences();
  List<Exercise> exercises = [];

  void toggleFavorite(String exerciseId) {
    if (preferences.favorites.contains(exerciseId)) {
      preferences.favorites.remove(exerciseId);
    } else {
      preferences.favorites.add(exerciseId);
    }
    PreferencesLoader().save(preferences);
    notifyListeners();
  }

  void changeReadingSpeed(int wpm) {
    preferences.readingSpeedInWpm = wpm;
    PreferencesLoader().save(preferences);
    notifyListeners();
  }

  void changeBreathPattern(BreathPattern pattern) {
    preferences.breathPattern = pattern;
    PreferencesLoader().save(preferences);
    notifyListeners();
  }

  Future<void> initState(AssetBundle bundle) async {
    if (status == MossyStatus.uninitialized) {
      try {
        preferences = await PreferencesLoader().load(preferences);
        print('preferences loaded!');
        exercises = await ExerciseLoader().loadAllExercises(bundle);
        print('exercises loaded!');
        status = MossyStatus.ready;
      } catch (e) {
        print('INITIALIZATION ERROR: ${e.toString()}');
        status = MossyStatus.error;
      }
      notifyListeners();
    }
  }

  MossyVibesState(AssetBundle bundle) {
    initState(bundle);
  }
}
