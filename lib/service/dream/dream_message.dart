class DreamMessage {
  final String text;
  final bool isUser;
  final bool isError;

  DreamMessage({
    required this.text,
    required this.isUser,
    this.isError = false,
  });
}
