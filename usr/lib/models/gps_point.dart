enum PointStatus {
  implantation,
  massifsRealises,
  panneauxPose,
}

class GpsPoint {
  String id;
  double latitude;
  double longitude;
  String note;
  PointStatus status;
  String? sitePhotoPath;
  String? planPhotoPath;
  DateTime createdAt;

  GpsPoint({
    required this.id,
    required this.latitude,
    required this.longitude,
    this.note = '',
    this.status = PointStatus.implantation,
    this.sitePhotoPath,
    this.planPhotoPath,
    required this.createdAt,
  });
}
