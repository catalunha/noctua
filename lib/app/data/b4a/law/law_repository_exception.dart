class LawRepositoryException implements Exception {
  final int code;
  final String message;
  LawRepositoryException({
    required this.code,
    required this.message,
  });
}
