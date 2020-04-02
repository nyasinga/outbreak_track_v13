import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:outbreak_tracker/entities/app_state.dart';
import 'package:outbreak_tracker/util/pages/ActiveCasesChartPage.dart';
import 'package:outbreak_tracker/util/GlobalAppConstants.dart';
import 'package:outbreak_tracker/util/pages/NewCasesChartPage.dart';

class RateOfSpreadPage extends StatelessWidget {
  final String currentCountry;

  RateOfSpreadPage(this.currentCountry);

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
          return Column(
            children: <Widget>[
              Text(currentCountry,
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 30),),
              Expanded(
                child: ClipRect(
                  child: Table(
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
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 80),
              ),
              Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    width: 300,
                    child: CupertinoButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'New Cases Graph',
                              style: TextStyle(
                                  color: CupertinoColors.black),
                            ),
                          ),
                          Icon(
                            CupertinoIcons.forward,
                            color: CupertinoColors.black,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(context, CupertinoPageRoute(
                            builder: (context) => NewCasesChartPage(null, true, state, currentCountry)
                        ));
                      },
                      color: CupertinoColors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    width: 300,
                    child: CupertinoButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Active Cases Graph',
                              style: TextStyle(
                                  color: CupertinoColors.black),
                            ),
                          ),
                          Icon(
                            CupertinoIcons.forward,
                            color: CupertinoColors.black,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(context, CupertinoPageRoute(
                            builder: (context) => ActiveCasesChartPage(null, true, state, currentCountry)));
                      },
                      color: CupertinoColors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 40),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  List<TableRow> generateTableRows(AppState state) {
    List<TableRow> rowList = new List<TableRow>();
    rowList.add(
      TableRow(
          decoration: BoxDecoration(
            color: GlobalAppConstants.appMainColor.withOpacity(0.5),
          ),
          children: [
            Center(
              child: Text(
                'Date',
                style: TextStyle(color: CupertinoColors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                'Total cases',
                style: TextStyle(color: CupertinoColors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                'New cases',
                style: TextStyle(color: CupertinoColors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                'Total deaths',
                style: TextStyle(color: CupertinoColors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                'Active cases',
                style: TextStyle(color: CupertinoColors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                'Total recovered',
                style: TextStyle(color: CupertinoColors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ]),
    );

    for (int i = (state.rateOfSpread.length - 1); i >= 0; i--) {
      rowList.add(TableRow(children: [
        Center(child: Text(state.rateOfSpread[i]['updated_at'].toString())),
        Center(child: Text(state.rateOfSpread[i]['total_cases'].toString())),
        Center(child: Text(state.rateOfSpread[i]['new_cases'].toString())),
        Center(child: Text(state.rateOfSpread[i]['total_deaths'].toString())),
        Center(child: Text(state.rateOfSpread[i]['active_cases'].toString())),
        Center(child: Text(state.rateOfSpread[i]['total_recovered'].toString())),
      ]));
    }
    return rowList;
  }
}
