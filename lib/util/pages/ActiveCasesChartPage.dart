

import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:outbreak_tracker/entities/app_state.dart';
import 'package:intl/intl.dart';

import '../GlobalAppConstants.dart';

class ActiveCasesChartPage extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final AppState state;
  final String currentCountry;

  ActiveCasesChartPage(this.seriesList, this.animate, this.state, this.currentCountry);
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");


  List<charts.Series<TimeSeriesActiveCases, DateTime>> _getActiveCasesData() {
    final List<TimeSeriesActiveCases> data = new List<TimeSeriesActiveCases>();

    for (int i = state.rateOfSpread.length - 1; i >= 0; i--) {
      DateTime dateTime = dateFormat.parse(state.rateOfSpread[i]['updated_at']);
      data.add(TimeSeriesActiveCases(dateTime,
          state.rateOfSpread[i]['active_cases']));
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
            Text("$currentCountry active cases",
              style: TextStyle(fontStyle: FontStyle.italic,
                  fontSize: 15),),
            Expanded(
              child: charts.TimeSeriesChart(
                _getActiveCasesData(),
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

class TimeSeriesActiveCases {
  final DateTime time;
  final int cases;

  TimeSeriesActiveCases(this.time, this.cases);
}
