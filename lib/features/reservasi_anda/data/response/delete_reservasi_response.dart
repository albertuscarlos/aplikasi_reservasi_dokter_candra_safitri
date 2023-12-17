class DeleteReservasiResponse {
  final bool status;
  final String? message;

  DeleteReservasiResponse({required this.status, this.message});

  factory DeleteReservasiResponse.fromJson(Map<String, dynamic> json) =>
      DeleteReservasiResponse(
        status: json['status'],
        message: json['message'],
      );
}
