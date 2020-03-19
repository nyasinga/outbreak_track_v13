

import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:outbreak_tracker/entities/app_state.dart';
import 'package:intl/intl.dart';

import '../GlobalAppConstants.dart';

class NewCasesChartPage extends StatelessWidget {
  List<charts.Series> seriesList;
  final bool animate;
  final AppState state;
  final String currentCountry;

  NewCasesChartPage(this.seriesList, this.animate, this.state, this.currentCountry);
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");


  List<charts.Series<TimeSeriesNewCases, DateTime>> _getNewCasesData() {
    final List<TimeSeriesNewCases> data = new List<TimeSeriesNewCases>();

    for (int i = state.rateOfSpread.length - 1; i >= 0; i--) {
      DateTime dateTime = dateFormat.parse(state.rateOfSpread[i]['updated_at']);
      data.add(TimeSeriesNewCases(dateTime,
          state.rateOfSpread[i]['new_cases']));
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

  @override
  Widget build(BuildContext context) {
    seriesList = _getNewCasesData();
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
                GlobalAppConstants.table,
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
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 100),
          child: Column(
            children: <Widget>[
              Text("$currentCountry new cases",
                style: TextStyle(fontStyle: FontStyle.italic,
                    fontSize: 15),),
              Expanded(
                child: charts.TimeSeriesChart(
                  seriesList,
                  animate: animate,
                  // Optionally pass in a [DateTimeFactory] used by the chart. The factory
                  // should create the same type of [DateTime] as the data provided. If none
                  // specified, the default creates local date time.
                  dateTimeFactory: const charts.LocalDateTimeFactory(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Text("Date",
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 15),),
            ],
          )
      ),

    );
  }
}

class TimeSeriesNewCases {
  final DateTime time;
  final int cases;

  TimeSeriesNewCases(this.time, this.cases);
}
