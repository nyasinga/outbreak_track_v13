

import 'package:flutter/cupertino.dart';
import 'package:outbreak_tracker/entities/Country.dart';

class AppState {
  Map<String, dynamic> countries;
  List<dynamic> rateOfSpread;
  List<dynamic> countryAdvisory;

  AppState({this.countries, this.rateOfSpread, this.countryAdvisory});

  AppState.fromAppState(AppState another) {
    countries = another.countries;
    rateOfSpread = another.rateOfSpread;
    countryAdvisory = another.countryAdvisory;
  }


}