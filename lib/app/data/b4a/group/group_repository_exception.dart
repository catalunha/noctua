class GroupRepositoryException implements Exception {
  final int code;
  final String message;
  GroupRepositoryException({
    required this.code,
    required this.message,
  });
}
