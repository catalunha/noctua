class OperationRepositoryException implements Exception {
  final int code;
  final String message;
  OperationRepositoryException({
    required this.code,
    required this.message,
  });
}
