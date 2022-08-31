class PersonRepositoryException implements Exception {
  final int code;
  final String message;
  PersonRepositoryException({
    required this.code,
    required this.message,
  });
}
