import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:outbreak_tracker/entities/app_state.dart';
import 'package:outbreak_tracker/util/GlobalAppConstants.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

import '../../entities/app_state.dart';
import '../GlobalAppConstants.dart';

class RateOfSpreadPage extends StatefulWidget {
  final String currentCountry;

  RateOfSpreadPage(this.currentCountry);

  @override
  _RateOfSpreadPageState createState() {
    return _RateOfSpreadPageState(currentCountry);
  }
}

class _RateOfSpreadPageState extends State<RateOfSpreadPage> {
  final List<charts.Series> seriesList = null;
  final bool animate = true;
  final AppState state = new AppState();
  bool showNewCases = false;
  String currentCountry;

  final DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  _RateOfSpreadPageState(String currentCountry) {
    this.currentCountry = currentCountry;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: <Widget>[
              Icon(
                CupertinoIcons.back,
                color: CupertinoColors.white,
              ),
              Text(
                "Country",
                style: TextStyle(
                  color: CupertinoColors.white,
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
          return ListView(
            children: <Widget>[
              Center(
                child: Text(
                  currentCountry,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Center(
                child: Text(
                  "Today",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("New Cases", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Text(state.rateOfSpread[state.rateOfSpread.length - 1]
                            ['new_cases']
                                .toString()),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                        ),
                        Column(
                          children: <Widget>[
                            Text("Recoveries", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Text(state.rateOfSpread[state.rateOfSpread.length - 1]
                            ['total_recovered']
                                .toString()),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("Active Cases", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Text(state.rateOfSpread[state.rateOfSpread.length - 1]
                            ['active_cases']
                                .toString()),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text("Deaths", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Text(state.rateOfSpread[state.rateOfSpread.length - 1]
                            ['total_deaths']
                                .toString()),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
              ),
              showNewCases
                  ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 400,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "$currentCountry's new cases graph",
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 15),
                          ),
                          Expanded(
                            child: charts.TimeSeriesChart(
                              _getNewCasesData(state),
                              animate: animate,
                              // Optionally pass in a [DateTimeFactory] used by the chart. The factory
                              // should create the same type of [DateTime] as the data provided. If none
                              // specified, the default creates local date time.
                              dateTimeFactory:
                                  const charts.LocalDateTimeFactory(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Text(
                            "Date",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ))
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 400,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "$currentCountry's active cases graph",
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 15),
                          ),
                          Expanded(
                            child: charts.TimeSeriesChart(
                              _getActiveCasesData(state),
                              animate: animate,
                              // Optionally pass in a [DateTimeFactory] used by the chart. The factory
                              // should create the same type of [DateTime] as the data provided. If none
                              // specified, the default creates local date time.
                              dateTimeFactory:
                                  const charts.LocalDateTimeFactory(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Text(
                            "Date",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      )),
              Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              Center(
                child: Container(
                  width: 200,
                  child: Container(
                    alignment: Alignment.center,
                    child: CupertinoButton(
                      color: GlobalAppConstants.appMainColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      child: showNewCases
                          ? Text(
                              "See active cases graph",
                              style: TextStyle(
                                color: CupertinoColors.white,
                              ),
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              "See new cases graph",
                              style: TextStyle(
                                color: CupertinoColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                      onPressed: () {
                        setState(() {
                          showNewCases = !showNewCases;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
              ),
              Center(
                child: Text(
                  "Scroll down for $currentCountry's rate of spread table below",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
              ),
              Table(
                  border: TableBorder.all(),
                  columnWidths: {
                    1: FractionColumnWidth(0.1),
                    2: FractionColumnWidth(0.16),
                    3: FractionColumnWidth(0.12),
                    4: FractionColumnWidth(0.16),
                    5: FractionColumnWidth(0.16),
                    6: FractionColumnWidth(0.12),
                  },
                  children: [
                    TableRow(
                        decoration: BoxDecoration(
                          color: GlobalAppConstants.appMainColor.withOpacity(0.5),
                        ),
                        children: [
                          Center(
                            child: Text(
                              'Date',
                              style: TextStyle(
                                  color: CupertinoColors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Total cases',
                              style: TextStyle(
                                  color: CupertinoColors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Text(
                              'New cases',
                              style: TextStyle(
                                  color: CupertinoColors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Total deaths',
                              style: TextStyle(
                                  color: CupertinoColors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Active cases',
                              style: TextStyle(
                                  color: CupertinoColors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Total recovered',
                              style: TextStyle(
                                  color: CupertinoColors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                  ]
              ),
              SizedBox(
                height: 400,
                child: ListView(
                  children: <Widget>[
                    Table(
                        border: TableBorder.all(),
                        columnWidths: {
                          1: FractionColumnWidth(0.1),
                          2: FractionColumnWidth(0.16),
                          3: FractionColumnWidth(0.12),
                          4: FractionColumnWidth(0.16),
                          5: FractionColumnWidth(0.16),
                          6: FractionColumnWidth(0.12),
                        },
                        children: generateTableRows(state)
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  List<charts.Series<TimeSeriesActiveCases, DateTime>> _getActiveCasesData(
      AppState state) {
    final List<TimeSeriesActiveCases> data = new List<TimeSeriesActiveCases>();

    for (int i = state.rateOfSpread.length - 1; i >= 0; i--) {
      DateTime dateTime = dateFormat.parse(state.rateOfSpread[i]['updated_at']);
      data.add(TimeSeriesActiveCases(
          dateTime, state.rateOfSpread[i]['active_cases']));
    }

    return [
      new charts.Series<TimeSeriesActiveCases, DateTime>(
        id: 'Cases',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesActiveCases cases, _) => cases.time,
        measureFn: (TimeSeriesActiveCases cases, _) => cases.cases,
        data: data,
      )
    ];
  }

  List<charts.Series<TimeSeriesNewCases, DateTime>> _getNewCasesData(
      AppState state) {
    final List<TimeSeriesNewCases> data = new List<TimeSeriesNewCases>();

    for (int i = state.rateOfSpread.length - 1; i >= 0; i--) {
      DateTime dateTime = dateFormat.parse(state.rateOfSpread[i]['updated_at']);
      data.add(
          TimeSeriesNewCases(dateTime, state.rateOfSpread[i]['new_cases']));
    }

    return [
      new charts.Series<TimeSeriesNewCases, DateTime>(
        id: 'Cases',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesNewCases cases, _) => cases.time,
        measureFn: (TimeSeriesNewCases cases, _) => cases.cases,
        data: data,
      )
    ];
  }

  List<TableRow> generateTableRows(AppState state) {
    List<TableRow> rowList = new List<TableRow>();

    for (int i = (state.rateOfSpread.length - 1); i >= 0; i--) {
      rowList.add(TableRow(children: [
        Center(child: Text(state.rateOfSpread[i]['updated_at'].toString())),
        Center(child: Text(state.rateOfSpread[i]['total_cases'].toString())),
        Center(child: Text(state.rateOfSpread[i]['new_cases'].toString())),
        Center(child: Text(state.rateOfSpread[i]['total_deaths'].toString())),
        Center(child: Text(state.rateOfSpread[i]['active_cases'].toString())),
        Center(
            child: Text(state.rateOfSpread[i]['total_recovered'].toString())),
      ]));
    }

    return rowList;
  }
}

class TimeSeriesNewCases {
  final DateTime time;
  final int cases;

  TimeSeriesNewCases(this.time, this.cases);
}

class TimeSeriesActiveCases {
  final DateTime time;
  final int cases;

  TimeSeriesActiveCases(this.time, this.cases);
}
