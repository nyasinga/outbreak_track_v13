class HotSpots {
  String updatedAt;
  String level;
  String latitude;
  int caseId;
  String createdAt;
  int id;
  String radius;
  int countryId;
  String longitude;


  HotSpots(this.updatedAt, this.level, this.latitude, this.caseId,
      this.createdAt, this.id, this.radius, this.countryId, this.longitude);

  HotSpots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updatedAt = json['updated_at'];
    level = json['level'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    caseId = json['case_id'];
    createdAt = json['created_at'];
    radius = json['radius'];
  }
}