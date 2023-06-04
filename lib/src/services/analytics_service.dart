import 'package:amplitude_flutter/amplitude.dart';
import 'package:localstorage/localstorage.dart';

const storageFile = 'analytics.json';

class AnalyticsService {
  Amplitude? amplitude;

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
    // make sure we establish that the user is opted out with Amplitude
    amplitude?.setOptOut(_analyticsDisabled!);

    _initAmplitude();
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

  Future<void> _initAmplitude() async {
    amplitude = Amplitude.getInstance(instanceName: 'mossy-vibes');
    const amplitudeKey = String.fromEnvironment('AMPLITUDE_API_KEY');
    amplitude!.init(amplitudeKey);
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

    // make sure we establish that the user is opted out with Amplitude
    amplitude?.setOptOut(_analyticsDisabled!);
  }

  Future<void> track(AnalyticsEventType type,
      [Map<String, dynamic> properties = const {}]) async {
    if (await analyticsDisabled) {
    } else {
      if (amplitude == null) {
        await _initAmplitude();
      }

      final Map<String, dynamic> updatedProperties = Map.from(properties);
      updatedProperties['type'] = type.name;
      updatedProperties['group'] = type.groupName;

      await amplitude!
          .logEvent(type.eventName, eventProperties: updatedProperties);

      await amplitude!
          .logEvent(type.groupName, eventProperties: updatedProperties);
    }
  }
}

enum AnalyticsEventType {
  exerciseVisited(eventName: 'Visited Exercise', groupName: 'Visit'),
  exerciseStarted(eventName: 'Started Exercise', groupName: 'Action'),
  exerciseCompleted(eventName: 'Completed Exercise', groupName: 'Action'),
  settingsVisited(eventName: 'Visited Settings', groupName: 'Visit'),
  settingsChanged(eventName: 'Changed Settings', groupName: 'Action'),
  aboutVisited(eventName: 'Visited About', groupName: 'Visit'),
  donateClicked(eventName: 'Clicked Donate', groupName: 'Action');

  const AnalyticsEventType({required this.groupName, required this.eventName});
  final String groupName;
  final String eventName;
}
