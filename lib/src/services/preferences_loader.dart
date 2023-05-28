import 'package:localstorage/localstorage.dart';

import '../models/preferences.dart';

/// The PreferencesLoader ensures that the preferences stored by the user
/// locally are retrievable and usable.
class PreferencesLoader {
  static final PreferencesLoader _preferencesLoader = PreferencesLoader._init();
  PreferencesLoader._init();

  /// Handles syncing preferences to and from the local storage.
  ///
  /// The PreferencesLoader helps facilitate the translation between model and
  /// JSON representation.
  factory PreferencesLoader() {
    return _preferencesLoader;
  }

  final storageFile = 'user.json';

  /// Sync any preferences in local storage to the preferences in local state.
  Future<UserPreferences> load(UserPreferences? initialPreferences) async {
    final LocalStorage storage = LocalStorage(storageFile);
    final defaultPreferences = initialPreferences ?? UserPreferences();

    await storage.ready;

    Map<String, dynamic> storedPrefs = storage.getItem('preferences') ?? {};
    defaultPreferences.parseJson(storedPrefs);

    return defaultPreferences;
  }

  /// Update the user's preferences in local storage.
  Future<bool> save(UserPreferences preferences) async {
    final LocalStorage storage = LocalStorage(storageFile);

    try {
      await storage.ready;
      await storage.setItem('preferences', preferences.toJson());
      return true;
    } catch (e) {
      print('PREFERENCE ERROR: $e');
      return false;
    }
  }
}
