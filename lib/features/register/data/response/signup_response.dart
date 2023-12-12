class SignUpResponse {
  final bool? status;
  final String message;

  SignUpResponse({
    this.status,
    required this.message,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        status: json["status"],
        message: json["message"],
      );
  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
