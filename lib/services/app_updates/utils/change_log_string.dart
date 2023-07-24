class ChangeLog {
  static String log({
    required String currentVersion,
    required String newChanges,
  }) =>
      '''
App Version: $currentVersion

Changelog: 

$currentVersion

-$newChanges
''';
}
