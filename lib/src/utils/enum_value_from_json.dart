/// Converts a string name into the appropriate enum value for that particular
/// enum type.
///
/// Because of the restrictions around enum extension in Dart, this requires
/// that the callers retrieve the values associated with the enum in order to
/// pass them into this function. The Enum Type will be inferred from the
/// values that are passed in.
T? enumValueFromJson<T extends Enum>(List<T> values, String name) {
  return values.asNameMap()[name];
}
