class AuthenticationException implements Exception {
  final String? code;
  final String? message;

  AuthenticationException({
    required this.code,
    required this.message,
  });
}
