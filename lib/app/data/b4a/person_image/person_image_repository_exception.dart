class PersonImageRepositoryException implements Exception {
  final int code;
  final String message;
  PersonImageRepositoryException({
    required this.code,
    required this.message,
  });
}
