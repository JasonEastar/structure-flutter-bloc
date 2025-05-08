import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConstants {
  static String get auth0Domain => dotenv.env['AUTH0_DOMAIN'] ?? '';
  static String get auth0ClientId => dotenv.env['AUTH0_CLIENT_ID'] ?? '';
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? '';
}
