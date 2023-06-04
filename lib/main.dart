import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/services/analytics_service.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '_state.dart';
import 'src/services/router.dart';
import 'src/utils/theme.dart';

void main() async {
  const sentryDsn = String.fromEnvironment('SENTRY_DSN');
  double sampleRate =
      double.tryParse(const String.fromEnvironment('SENTRY_SAMPLE_RATE')) ??
          1.0;

  // the application is wrapped in Sentry to aid in error reporting and basic
  // analytics
  await SentryFlutter.init((options) {
    options.dsn = sentryDsn;
    options.tracesSampleRate = sampleRate;
    options.beforeSend = (event, {hint}) async {
      if (await AnalyticsService().analyticsDisabled) {
        print('INFO: crash log not sent because analytics are disabled');
        return null;
      } else {
        return event.copyWith(serverName: null); // remove device ID
      }
    };
  }, appRunner: () {
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    AnalyticsService().track(AnalyticsEventType.mossyVibesOpened);
    return runApp(SentryUserInteractionWidget(child: MossyVibes()));
  });
}

class MossyVibes extends StatelessWidget {
  /// Mossy Vibes is a simple, reading-based meditation app built with Flutter.
  ///
  /// It does very little server communication, only refreshing the available
  /// meditations when the user loads the app when they are online. This is
  /// purposeful, to keep the
  const MossyVibes({super.key});

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
                primary: MossyColors.darkGreen,
                onPrimary: MossyColors.offWhite,
                secondary: MossyColors.lightGreen,
                onSecondary: MossyColors.darkBrown,
                brightness: Brightness.dark,
                error: MossyColors.yellow,
                onError: MossyColors.offBlack,
                surface: Colors.transparent,
                onSurface: MossyColors.offBlack)),
      ),
    );
  }
}
