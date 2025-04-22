class DreamMessage {
  final String text;
  final bool isUser;
  final bool isError;
  final bool isLoading;

  DreamMessage({
    required this.text,
    required this.isUser,
    this.isError = false,
    this.isLoading = false,
  });
}
