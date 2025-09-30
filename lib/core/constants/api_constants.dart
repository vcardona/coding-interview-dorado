class ApiConstants {
  ApiConstants._();

  // Base URL
  static const String baseUrl =
      'https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage';

  // Endpoints
  static const String recommendations = '/orderbook/public/recommendations';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
