class RateOfSpread {
  int id;
  int totalCases;
  int totalDeaths;
  String updatedAt;
  int newCases;
  int caseId;
  String createdAt;
  int totalRecovered;
  int activeCases;
  int countryId;
  String date;


  RateOfSpread(this.id, this.date, this.totalCases, this.totalDeaths,
      this.updatedAt, this.newCases, this.caseId, this.createdAt,
      this.totalRecovered, this.activeCases, this.countryId);

  RateOfSpread.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalCases = json['total_cases'];
    totalDeaths = json['total_deaths'];
    updatedAt = json['updated_at'];
    newCases = json['new_cases'];
    caseId = json['case_id'];
    createdAt = json['created_at'];
    totalRecovered = json['total_recovered'];
    activeCases = json['active_cases'];
    countryId = json['country_id'];
    date = json['date'];
  }
}