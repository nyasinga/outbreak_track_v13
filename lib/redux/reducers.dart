

import 'package:outbreak_tracker/entities/app_state.dart';
import 'package:outbreak_tracker/redux/actions.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is Countries) {
    newState.countries = action.payload;
  }
  else if (action is RateOfSpreadAction) {
    newState.rateOfSpread = action.payload;
  }
  else if (action is CountryAdvisoryAction) {
    newState.countryAdvisory = action.payload;
  }

  return newState;
}