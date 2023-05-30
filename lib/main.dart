import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '_state.dart';
import 'src/services/router.dart';
import 'src/utils/theme.dart';

void main() async {
  const sentryDsn = String.fromEnvironment('sentry_dsn');
  double sampleRate =
      double.tryParse(const String.fromEnvironment('sentry_sample_rate')) ??
          1.0;

  // the application is wrapped in Sentry to aid in error reporting and basic
  // analytics
  await SentryFlutter.init((options) {
    options.dsn = sentryDsn;
    options.tracesSampleRate = sampleRate;
  }, appRunner: () {
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
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
