import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '_state.dart';
import 'firebase_options.dart';
import 'src/services/router.dart';
import 'src/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  // we're not using Firebase for anything meaningful currently, but we still
  // make sure its initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // the application is wrapped in Sentry to aid in error reporting and basic
  // analytics
  await SentryFlutter.init((options) {
    options.dsn = dotenv.env['SENTRY_DSN'];
    options.tracesSampleRate = 1.0;
  }, appRunner: () => runApp(MossyVibes()));
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
