import 'package:localstorage/localstorage.dart';

const storageFile = 'analytics.json';

class AnalyticsService {
  /// True if the user has declined collecting analytics on their system. The
  /// default is to collect analytics, since they are anonymized and not used
  /// for advertising
  Future<bool> get analyticsDisabled async {
    return _analyticsDisabled ?? await _loadAnalyticsStatus();
  }

  bool? _analyticsDisabled;

  static AnalyticsService _analyticsService = AnalyticsService._init();
  AnalyticsService._init() {
    _loadAnalyticsStatus();
  }

  /// Handles sending anonymized analytics to the tools used by Mossy Vibes.
  /// Designed to be vendor agnostic so we can opt to switch to a different
  /// vendor down the road if we'd prefer.
  factory AnalyticsService() {
    return _analyticsService;
  }

  Future<bool> _loadAnalyticsStatus() async {
    final LocalStorage storage = LocalStorage(storageFile);
    await storage.ready;
    return storage.getItem('analyticsDisabled') ?? false;
  }

  /// allows the user to opt out of sending any analytics
  Future<void> toggleCollectionOfAnalytics([bool? disableAnalytics]) async {
    if (disableAnalytics != null) {
      _analyticsDisabled = disableAnalytics;
    } else {
      _analyticsDisabled ??= await _loadAnalyticsStatus();
      _analyticsDisabled = !_analyticsDisabled!;
    }

    // store the changed permission back to storage
    final LocalStorage storage = LocalStorage(storageFile);
    await storage.ready;
    await storage.setItem('analyticsDisabled', _analyticsDisabled);
  }

  Future<void> track(AnalyticEventType type,
      [Map<String, dynamic> properties = const {}]) async {
    if (await analyticsDisabled) {
      print('INFO: analytics disabled for user');
    } else {
      print('tracking event "${type.name}"');
    }
  }
}

enum AnalyticEventType {
  exerciseVisited,
  exerciseStarted,
  exerciseCompleted,
  settingsVisited,
  settingsChanged,
  aboutVisited,
  donateClicked
}
