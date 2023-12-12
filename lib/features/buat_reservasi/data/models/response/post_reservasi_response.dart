class PostReservasiResponse {
  final bool status;
  final String message;

  PostReservasiResponse({required this.status, required this.message});

  factory PostReservasiResponse.fromJson(Map<String, dynamic> json) =>
      PostReservasiResponse(
        status: json["status"],
        message: json["message"],
      );
}
