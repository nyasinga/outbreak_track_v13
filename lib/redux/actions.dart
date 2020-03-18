
import 'package:outbreak_tracker/entities/RateOfSpread.dart';

class Countries {
  final Map<String, dynamic> payload;

  Countries(this.payload);

}

class RateOfSpreadAction {
  final List<dynamic> payload;

  RateOfSpreadAction(this.payload);

}

class CountryAdvisoryAction {
  final List<dynamic> payload;

  CountryAdvisoryAction(this.payload);
}

class HotSpotsAction {
  final List<dynamic> payload;

  HotSpotsAction(this.payload);
}