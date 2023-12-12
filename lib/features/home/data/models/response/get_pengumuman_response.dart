class PengumumanData {
  final String id;
  final String pengumuman;

  PengumumanData({
    required this.id,
    required this.pengumuman,
  });

  factory PengumumanData.fromModel(Map<String, dynamic> json) => PengumumanData(
        id: json["id"],
        pengumuman: json["pengumuman"],
      );
}

class PengumumanResponse {
  final List<PengumumanData>? data;
  final bool? status;
  final String? message;

  PengumumanResponse({required this.data, this.status, this.message});

  factory PengumumanResponse.fromJson(Map<String, dynamic> json) =>
      PengumumanResponse(
        data: json["data"] != null
            ? List.from(
                json["data"].map(
                  (pengumuman) => PengumumanData.fromModel(pengumuman),
                ),
              )
            : null,
        status: json["status"],
        message: json["message"],
      );
}
