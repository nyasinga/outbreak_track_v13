import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:outbreak_tracker/entities/app_state.dart';
import 'package:outbreak_tracker/redux/actions.dart';
import 'package:outbreak_tracker/util/GlobalAppConstants.dart';
import 'package:http/http.dart' as http;
import 'package:outbreak_tracker/util/ProgressBarHelper.dart';

class DialogHelpers {

  showRateOfSpreadData(BuildContext context, int countryId, int caseId) {
    ProgressBarHelper(context).showProgressBar();
    getRateOfSpread(countryId, caseId).then((value) {
      StoreProvider.of<AppState>(context).dispatch(RateOfSpreadAction(value));

      return showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                GlobalAppConstants.rateOfSpread,
                style: TextStyle(color: GlobalAppConstants.appMainColor),
              ),
              content: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  return Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      height: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(GlobalAppConstants.totalCases),
                              Text(GlobalAppConstants.newCases),
                              Text('Total deaths: '),
                              Text('Active cases: '),
                              Text('Total recovered: '),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(state.rateOfSpread.last['total_cases']
                                  .toString()),
                              Text(state.rateOfSpread.last['new_cases']
                                  .toString()),
                              Text(state.rateOfSpread.last['total_deaths']
                                  .toString()),
                              Text(state.rateOfSpread.last['active_cases']
                                  .toString()),
                              Text(state.rateOfSpread.last['total_recovered']
                                  .toString()),
                            ],
                          )
                        ],
                      ));
                },
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(GlobalAppConstants.dismiss),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    });
  }

  showCountryData(BuildContext context, int countryId, int caseId) {
    ProgressBarHelper(context).showProgressBar();
    getCountryAdvisory(countryId, caseId).then((value) {
      if (value.length == 0) {
        Map<String, dynamic> values = new Map<String, dynamic>();
        values['id'] = 0;
        values['country_id'] = countryId;
        values['case_id'] = caseId;
        values['travel_advisories'] = 'Information Unavailable';
        values['special_measures'] = 'Information Unavailable';
        values['quarantines'] = 'Information Unavailable';
        values['prepared_hospitals'] = 'Information Unavailable';
        values['additional_info'] = 'Information Unavailable';
        values['created_at'] = 'Information Unavailable';
        values['updated_at'] = 'Information Unavailable';
        value.add(values);
      }
      StoreProvider.of<AppState>(context)
          .dispatch(CountryAdvisoryAction(value));

      return showCupertinoDialog(
          context: context,
          useRootNavigator: true,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                GlobalAppConstants.countryData,
                style: TextStyle(color: GlobalAppConstants.appMainColor),
              ),
              content: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  return Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      height: 600,
                      width: 600,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                      'Travel Advisories: ${state.countryAdvisory.last['travel_advisories']}'),
                                ),
                                Flexible(
                                    child: Text(
                                        'Special Measures: ${state.countryAdvisory.last['special_measures']}')),
                                Flexible(
                                    child: Text(
                                        'Quarantines: ${state.countryAdvisory.last['quarantines']}')),
                                Flexible(
                                    child: Text(
                                        'Prepared Hospitals: ${state.countryAdvisory.last['prepared_hospitals']}')),
                                Flexible(
                                    child: Text(
                                        'Additional Info: ${state.countryAdvisory.last['additional_info']}')),
                              ],
                            ),
                          )
                        ],
                      ));
                },
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(GlobalAppConstants.dismiss),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    });
  }

  showHotspotData(BuildContext context, int countryId, int caseId) {
    ProgressBarHelper(context).showProgressBar();
    getHotSpots(countryId, caseId).then((value) {
      if (value.length == 0) {
        Map<String, dynamic> values = new Map<String, dynamic>();
        values['id'] = 0;
        values['country_id'] = countryId;
        values['case_id'] = caseId;
        values['latitude'] = 'Information Unavailable';
        values['longitude'] = 'Information Unavailable';
        values['level'] = 'Information Unavailable';
        values['radius'] = 'Information Unavailable';
        value.add(values);
      }
      StoreProvider.of<AppState>(context)
          .dispatch(HotSpotsAction(value));

      return showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                GlobalAppConstants.hotspot,
                style: TextStyle(color: GlobalAppConstants.appMainColor),
              ),
              content: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  return Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      height: 200,
                      width: 600,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                  child: Text('Latitude: '),
                                ),
                                Flexible(
                                  child: Text('Longitude: '),
                                ),
                                Flexible(
                                  child: Text('Level: '),
                                ),
                                Flexible(
                                  child: Text('Radius: '),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(state.hotSpots.last['latitude']),
                              Text(state.hotSpots.last['longitude']),
                              Text(state.hotSpots.last['level']),
                              Text(state.hotSpots.last['radius']),
                            ],
                          )
                        ],
                      )
                  );
                },
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(GlobalAppConstants.dismiss),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    });
  }

  Future<List<dynamic>> getRateOfSpread(int countryId, int caseId) async {
    List<dynamic> rates = new List<dynamic>();

    http.Response response = await http.get(
        Uri.encodeFull(
            'http://outbreak.africanlaughterpr.com/api/growth-rates/country/case/list?country_id=$countryId&case_id=$caseId'),
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      var ratesData = json.decode(response.body);
      rates = ratesData['growth_rates'];
    }

    return rates;
  }

  Future<List<dynamic>> getCountryAdvisory(int countryId, int caseId) async {
    List<dynamic> advisory = new List<dynamic>();

    http.Response response = await http.get(
        Uri.encodeFull(
            'http://outbreak.africanlaughterpr.com/api/datasheets/country/list?country_id=$countryId'),
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      var advisoryData = json.decode(response.body);
      advisory = advisoryData['datasheets'];
    }

    return advisory;
  }

  Future<List<dynamic>> getHotSpots(int countryId, int caseId) async {
    List<dynamic> hotspots = new List<dynamic>();

    http.Response response = await http.get(
        Uri.encodeFull(
            'http://outbreak.africanlaughterpr.com/api/hotspots/country/list?country_id=$countryId'),
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      var hotSpotsData = json.decode(response.body);
      hotspots = hotSpotsData['hotspots'];
    }

    return hotspots;
  }
}
