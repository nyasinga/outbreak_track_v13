import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:outbreak_tracker/entities/app_state.dart';
import 'package:outbreak_tracker/util/GlobalAppConstants.dart';

class CountryDataPage extends StatelessWidget {
  final String currentCountry;

  CountryDataPage(this.currentCountry);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: Row(
            children: <Widget>[
              Icon(
                CupertinoIcons.back,
                color: CupertinoColors.white,
              ),
              Flexible(
                child: Text(
                  "Country",
                  style: TextStyle(
                    color: CupertinoColors.white,
                  ),
                ),
              )
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: GlobalAppConstants.appMainColor,
      ),
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Column(
            children: <Widget>[
              Container(
                child: Text(currentCountry,
                  style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 30),),
                padding: EdgeInsets.only(top: 10.0),
              ),
              state.countryAdvisory.length > 0 ? Expanded(
                child: ListView.builder(
                  itemCount: state.countryAdvisory.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Center(child: Text('Lockdown', style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.white),)),
                                      color: GlobalAppConstants.appMainColor,
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                    ),
                                  ),
                                ],
                              ),
                              state.countryAdvisory[i]['travel_advisories'] != null ?
                              Text(state.countryAdvisory[i]['travel_advisories']):
                                  Text("None so far"),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Center(child: Text('Travel', style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.white),)),
                                      color: GlobalAppConstants.appMainColor,
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                    ),
                                  ),
                                ],
                              ),
                              state.countryAdvisory[i]['special_measures'] != null ?
                              Text(state.countryAdvisory[i]['special_measures']):
                              Text("None so far"),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Center(child: Text('Special Measures', style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.white),)),
                                      color: GlobalAppConstants.appMainColor,
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                    ),
                                  ),
                                ],
                              ),
                              state.countryAdvisory[i]['quarantines'] != null ?
                              Text(state.countryAdvisory[i]['quarantines']):
                              Text("None so far"),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Center(child: Text('Food', style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.white),)),
                                      color: GlobalAppConstants.appMainColor,
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                    ),
                                  ),
                                ],
                              ),
                              state.countryAdvisory[i]['prepared_hospitals'] != null ?
                              Text(state.countryAdvisory[i]['prepared_hospitals']):
                              Text("None so far"),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
              : Padding(
                padding: const EdgeInsets.symmetric(vertical: 200, horizontal: 100),
                child: Center(
                  child: Text('No updates posted for the current country so far.',
                    style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 30),
                  ),
                ),
              )
            ]
          );
        },
      ),
    );
  }
}
