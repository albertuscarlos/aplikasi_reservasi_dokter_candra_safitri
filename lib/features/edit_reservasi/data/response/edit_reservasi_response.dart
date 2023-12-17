class EditReservasiResponse {
  EditReservasiResponse({
    this.status,
    this.message,
  });

  factory EditReservasiResponse.fromJson(Map<String, dynamic> json) =>
      EditReservasiResponse(
        status: json['status'],
      );

  final bool? status;
  final String? message;
}
