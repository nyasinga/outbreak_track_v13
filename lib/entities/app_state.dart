

import 'package:flutter/cupertino.dart';
import 'package:outbreak_tracker/entities/Country.dart';

class AppState {
  Map<String, dynamic> countries;
  List<dynamic> rateOfSpread;
  List<dynamic> countryAdvisory;
  List<dynamic> hotSpots;

  AppState({this.countries, this.rateOfSpread, this.countryAdvisory, this.hotSpots});

  AppState.fromAppState(AppState another) {
    countries = another.countries;
    rateOfSpread = another.rateOfSpread;
    countryAdvisory = another.countryAdvisory;
    hotSpots = another.hotSpots;
  }


}