import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/models/breath_pattern.dart';
import 'package:mossy_vibes/src/models/exercise.dart';
import 'package:mossy_vibes/src/models/preferences.dart';
import 'package:mossy_vibes/src/services/analytics_service.dart';
import 'package:mossy_vibes/src/services/exercise_service.dart';
import 'package:mossy_vibes/src/services/preferences_service.dart';

enum MossyStatus { loading, ready, error, uninitialized }

class MossyVibesState extends ChangeNotifier {
  MossyStatus status = MossyStatus.uninitialized;
  UserPreferences preferences = UserPreferences();
  List<Exercise> exercises = [];

  /// Tracks all of the global state for the application.
  ///
  /// The state uses the loaders to retrieve state from the local storage and
  /// to save back to local storage. There is not any in-app state stored across
  /// sessions.
  MossyVibesState(AssetBundle bundle) {
    _initState(bundle);
  }

  /// Loads in all of the relevant data for the application
  ///
  /// This both retrieves information from local storage and from the open
  /// internet if the user has connectivity
  Future<void> _initState(AssetBundle bundle) async {
    if (status == MossyStatus.uninitialized) {
      try {
        preferences = await PreferencesService().load(preferences);
        exercises = await ExerciseService().loadAllExercises(bundle);
        status = MossyStatus.ready;
      } catch (e) {
        print('INITIALIZATION ERROR: ${e.toString()}');
        status = MossyStatus.error;
      }
      notifyListeners();
    }
  }

  /// Flags or unflags an exercise as a favorite for the user.
  ///
  /// Toggle favorite is called whenever the user clicks the Star icon.
  void toggleFavorite(String exerciseId) {
    if (preferences.favorites.contains(exerciseId)) {
      preferences.favorites.remove(exerciseId);
    } else {
      preferences.favorites.add(exerciseId);
    }
    PreferencesService().save(preferences);
    notifyListeners();
  }

  /// Updates the preferred word highlight speed for the user
  ///
  /// The user can update this from the settings screen. It will get stored
  /// into local storage.
  void changeReadingSpeed(int wpm) {
    preferences.readingSpeedInWpm = wpm;
    PreferencesService().save(preferences);
    AnalyticsService().track(AnalyticsEventType.settingsChanged,
        {'type': 'readingSpeed', 'value': wpm});
    notifyListeners();
  }

  /// Updates the preferred breath leangth for the user
  ///
  /// The user can update this from the settings screen. It will get stored
  /// into local storage.
  void changeBreathPattern(BreathPattern pattern) {
    preferences.breathPattern = pattern;
    PreferencesService().save(preferences);
    AnalyticsService().track(AnalyticsEventType.settingsChanged,
        {'type': 'breathPattern', 'value': pattern.name});
    notifyListeners();
  }
}
