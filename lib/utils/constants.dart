class Constants {
  static String basePath = "libr/redux";
  static String configPath = "lib/config";
  static String jsonModelsPath = "libr/models";

  /// (final|late) [a-zA-Z0-9]+(<[a-zA-Z0-9]+(\?)?>)?(\?)? ([a-zA-Z0-9])+
  static final RegExp parameterRegex = RegExp(
      r'(final|late) [a-zA-Z0-9]+(<[a-zA-Z0-9]+(\?)?>)?(\?)? ([a-zA-Z0-9])+');

  /// class [a-zA-Z0-9]+ {([\S\s]*?)\n}
  static final RegExp actionRegex =
      RegExp(r'class [a-zA-Z0-9]+ {([\S\s]*?)\n}');

  /// [\w]+ [\w]+\((\n( |\t)*)*[\w]+ [\w]+,(\n( |\t)*)* [\w]+ [\w]+\) {([\S\s]*?)\n}
  static final RegExp actionImplementationRegex = RegExp(
      r"[\w]+ [\w]+\((\n( |\t)*)*[\w]+ [\w]+,(\n( |\t)*)* [\w]+ [\w]+\) {([\S\s]*?)\n}");

  /// , [\w]+ [\w]+\)
  static final RegExp actionNameRegex = RegExp(r", [\w]+ [\w]+\)");

  static void updateBasePath(String dir) {
    Constants.basePath =
        dir + (dir.toLowerCase().contains("redux") ? "" : "/redux");
    Constants.configPath = "${Constants.basePath}/../config";
    Constants.jsonModelsPath = "${Constants.basePath}/../json_models";
  }
}
