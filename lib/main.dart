import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:outbreak_tracker/HomePage.dart';
import 'package:outbreak_tracker/entities/Country.dart';
import 'package:outbreak_tracker/entities/app_state.dart';
import 'package:outbreak_tracker/redux/reducers.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  getAllCountries().then((value) {
    Map<String, dynamic> countries;
    countries = value;
    final _initialState = AppState(countries: countries);
    final Store<AppState> _store =
    Store<AppState>(reducer, initialState: _initialState);
    runApp(OutbreakTrackerApp(store: _store));
  });
}

Future<Map<String, dynamic>> getAllCountries() async {
  List<dynamic> countries = new List<dynamic>();
  Map<String, dynamic> countriesMap = new Map<String, dynamic>();
  http.Response response = await http.get(Uri.encodeFull('http://outbreak.africanlaughterpr.com/api/countries/list'),
    headers: {'Accept': 'application/json'}
  );

  if (response.statusCode == 200) {
    var countriesData = json.decode(response.body);
    countries = countriesData['countries'];
    for (int i = 0; i < countries.length; i++) {
      countriesMap[countries[i]['name']] = countries[i];
    }
  }

  return countriesMap;
}

class OutbreakTrackerApp extends StatelessWidget {
  final Store<AppState> store;
  OutbreakTrackerApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: CupertinoApp(
        theme: CupertinoThemeData(

        ),
        title: 'Outbreak Tracker',
        home: HomePage(),
      ),
    );
  }
}
