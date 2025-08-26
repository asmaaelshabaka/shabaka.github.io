
class AppEnvironment {
  static String? firebaseConfigJson;
  static String? initialAuthToken;
  static String? appId;

  // Private constructor to prevent instantiation
  AppEnvironment._();

  // Method to initialize the environment variables
  static void initialize({
    required String? configJson,
    required String? authToken,
    required String? applicationId,
  }) {
    firebaseConfigJson = configJson;
    initialAuthToken = authToken;
    appId = applicationId;
    print('AppEnvironment initialized: App ID = $appId');
  }
}
