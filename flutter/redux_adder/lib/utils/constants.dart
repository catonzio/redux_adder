class Constants {
  static String basePath = "lib/redux";
  static String configPath = "lib/config";
  static String jsonModelsPath = "lib/models";

  static final RegExp parameterRegex = RegExp(
      r'(final|late) [a-zA-Z0-9]+(<[a-zA-Z0-9]+(\?)?>)?(\?)? ([a-zA-Z0-9])+');
  static final RegExp actionRegex = RegExp(r'class [a-zA-Z0-9]+ {([\S\s]*?)\n}');

  static void updateBasePath(String dir) {
    Constants.basePath =
        dir + (dir.toLowerCase().contains("redux") ? "" : "/redux");
    Constants.configPath = "${Constants.basePath}/../config";
    Constants.jsonModelsPath = "${Constants.basePath}/../json_models";
  }
}
