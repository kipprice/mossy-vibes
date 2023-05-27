import 'dart:core';

import 'package:mossy_vibes/src/utils/constants.dart';

import '../utils/enum_value_from_json.dart';
import 'preferences.dart';
import 'prompt.dart';

enum ExerciseSize { micro, normal, lengthy }

class Exercise {
  /// Unique identifier for the exercise
  ///
  /// Almost always, this is also the title of the file containing this exercise
  String id;

  /// Display title for the exercise
  String? title;

  /// The content that makes up the exercise.
  ///
  /// Prompts contain context on timing and content, and calculate their own
  /// length, which is then summed up by the Exercise.
  List<Prompt> prompts = [];

  /// The author of this particular exercise.
  ///
  /// Currently, this is free-text, but in the future it will likely also
  /// allow for some context per author.
  String? author;

  /// Metadata associated with this exercise.
  ///
  /// Tags are free-text and assigned by the author.
  List<String>? tags = [];

  /// The particular size category this exercise falls into.
  ///
  /// Exercises fall into one of three buckets
  ///   - standard (3 - 14mins)
  ///   - micro (<2 mins)
  ///   - lengthy (15+ minutes)
  ExerciseSize? size;

  /// The instant at which this exercise was created.
  ///
  /// Because Mossy Vibes has continuous addition of exercises, we track the
  /// date at which a particular exercise was added to highlight new additions.
  DateTime? dateAdded;

  /// Stores details about a particular meditation exercise.
  ///
  /// Exercises are the backbone of Mossy Vibes. They are self-contained
  /// meditations, usually 5 - 10 minutes. Each exercise tracks its own content
  /// and timing. It accounts for user preferences when determining favorite
  /// status or
  Exercise(
      {required this.id,
      this.title,
      this.prompts = const [],
      this.author,
      this.tags,
      this.size = ExerciseSize.normal,
      this.dateAdded});

  /// Calculates the amount of time, in seconds, it will take for the user to
  /// go through all of the Prompts included in this exercise
  ///
  /// Each prompt calculates its own length, which is then included in the
  /// exercise total.
  int getLengthInSeconds(UserPreferences preferences) {
    int length = 0;

    for (var prompt in prompts) {
      length += prompt.getLengthInSeconds(preferences);
    }

    return length;
  }

  /// Calculates the amount of time, in minutes, it will take for the user to
  /// go through all of the Prompts included in this exercise
  ///
  /// The amount of time in minutes is always rounded up to the nearest minute.
  int getLengthInMinutes(UserPreferences preferences) {
    return (getLengthInSeconds(preferences) / secondsPerMinute).ceil();
  }

  /// Determines if this exercise has been flagged as a favorite by the user.
  bool isFavorite(UserPreferences preferences) {
    return preferences.favorites.contains(id);
  }

  /// Determines if this exercise has already been completed by the user.
  bool isCompleted(UserPreferences preferences) {
    final completionDetails =
        preferences.completedExercises.where((d) => d.exerciseId == id);
    if (completionDetails.isNotEmpty) {
      return true;
    }
    return false;
  }

  /// Transforms this exercise object into one that can be safely saved in JSON
  /// format.
  ///
  /// Used to serialize / deserialize the model into the local storage, so a
  /// user does not need to be connected to the internet to be able to access
  /// exercises.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'tags': tags,
      'size': size?.name,
      'dateAdded': dateAdded?.toIso8601String() ?? '',
      'prompts': prompts.map((p) => p.toJson()).toList()
    };
  }

  /// Transform the JSON representation of this exercise into a full instance
  /// of the Exercise class.
  ///
  /// Used to deserialize the local version of an Exercise into one that is
  /// usable by the application.
  factory Exercise.fromJson(dynamic json) {
    return Exercise(
        id: json['id'],
        title: json['title'],
        author: json['author'],
        tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
        size: json['size'] != null
            ? enumValueFromJson(ExerciseSize.values, json['size'])
            : null,
        dateAdded: DateTime.tryParse(json['dateAdded']),
        prompts:
            List<Prompt>.from(json['prompts'].map((p) => Prompt.fromJson(p))));
  }
}
