import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import '../../exercise_parser.dart';
import '../../../models/exercise.dart';
import '_exercise_loader.dart';

class RemoteExerciseLoader extends ExerciseLoader {
  String downloadUri;

  /// Handles loading an exercise from the remote repository of exercises
  /// available in Mossy Vibes
  ///
  /// The remote exercise loader retrieves information from Github and includes
  /// it within the application.
  ///
  /// Mossy Vibes is intended to generally be an offline application, but we
  /// still want to be able to update the user's local device with the latest
  /// and greatest from the Mossy Vibes server. We've opted to do this through
  /// GitHub to start, since it allows us to query without a ton of auth
  /// overhead. GitHub does have some limiting volume, so if Mossy Vibes ends
  /// up growing beyond a certain scale, we can transition this function to a
  /// more stable endpoint.
  ///
  /// These exercises, once retrieved, are then stored in local storage to
  /// ensure that if the user later does not have internet access, they can
  /// still retrieve these exercises.
  ///
  /// TODO: build in backoff handling
  RemoteExerciseLoader(
      {required super.exerciseId,
      super.type = 'REMOTE',
      required this.downloadUri});

  /// Inner function for loading details about an exercise from Github
  @override
  Future<Exercise?> handleLoad() async {
    final resp = await http.get(Uri.parse(downloadUri));
    if (resp.statusCode == 200) {
      return ExerciseParser().parse(exerciseId, resp.body);
    } else {
      return null;
    }
  }

  /// Generates the set of loaders that can then download exercises on behalf
  /// of Mossy Vibes.
  static Future<List<ExerciseLoader>> loadList() async {
    // make sure we are connected to the internet before trying anything else
    if (!(await _isConnected)) {
      return [];
    }

    // attempt to retrieve the list of all files hosted on GitHub
    final listUrl = Uri.parse(
        'https://api.github.com/repos/kipprice/mossy-vibes/contents/assets/exercises');

    final listResp = await http.get(listUrl);
    if (listResp.statusCode != 200) {
      return [];
    }

    // loop through each file and add a loader for it, as long as we can figure
    // out where to retrieve it from
    try {
      List<dynamic> listBody = jsonDecode(listResp.body);
      List<RemoteExerciseLoader> out = [];
      for (var fileDetails in listBody) {
        RegExp idRegex = RegExp(r'/([^/]*?).md$');
        RegExpMatch? idMatch =
            idRegex.firstMatch(fileDetails['download_url'] ?? '');
        if (idMatch == null || idMatch[1] == null) {
          continue;
        }
        out.add(RemoteExerciseLoader(
            exerciseId: idMatch[1]!, downloadUri: fileDetails['download_url']));
      }
      return out;
    } catch (e) {
      return [];
    }
  }

  /// helper function to determine whether it is worth trying to retrieve any
  /// information from the internet.
  ///
  /// Verifies that the user is connected to one potential internet source
  /// (wifi, ethernet, mobile data, or vpn).
  static Future<bool> get _isConnected async {
    final connectivityResults = await (Connectivity().checkConnectivity());

    // ensure there's a perceived connection before trying to retrieve exercises
    // from the open endpoint.
    final hasEthernet =
        connectivityResults.contains(ConnectivityResult.ethernet);
    final hasMobile = connectivityResults.contains(ConnectivityResult.mobile);
    final hasVpn = connectivityResults.contains(ConnectivityResult.vpn);
    final hasWifi = connectivityResults.contains(ConnectivityResult.wifi);

    return hasEthernet || hasMobile || hasVpn || hasWifi;
  }
}
