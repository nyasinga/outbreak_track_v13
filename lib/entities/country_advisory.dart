class CountryAdvisory {
  int id;
  String updatedAt;
  String additionalInfo;
  String specialMeasures;
  int caseId;
  String travelAdvisories;
  String quarantines;
  String createdAt;
  String preparedHospitals;
  int countryId;


  CountryAdvisory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caseId = json['case_id'];
    countryId = json['country_id'];
    updatedAt = json['updated_at'];
    additionalInfo = json['additional_info'];
    specialMeasures = json['special_measures'];
    travelAdvisories = json['travel_advisories'];
    quarantines = json['quarantines'];
    createdAt = json['created_at'];
    preparedHospitals = json['prepared_hospitals'];
  }
}