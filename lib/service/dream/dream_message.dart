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

  /// 직렬화 (저장용)
  Map<String, dynamic> toJson() => {
        'text': text,
        'isUser': isUser,
        'isError': isError,
        'isLoading': isLoading,
      };

  /// 역직렬화 (복원용)
  factory DreamMessage.fromJson(Map<String, dynamic> json) => DreamMessage(
        text: json['text'],
        isUser: json['isUser'],
        isError: json['isError'] ?? false,
        isLoading: json['isLoading'] ?? false,
      );
}
