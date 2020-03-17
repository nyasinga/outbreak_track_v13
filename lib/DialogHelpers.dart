import 'package:flutter/cupertino.dart';
import 'package:outbreak_tracker/util/GlobalAppConstants.dart';

class DialogHelpers {
  showRateOfSpreadData(BuildContext context) {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              GlobalAppConstants.rateOfSpread,
              style: TextStyle(color: GlobalAppConstants.appMainColor),
            ),
            content: Container(
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
//                    Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      mainAxisSize: MainAxisSize.max,
//                      children: <Widget>[
//                        Text('$totalCases'),
//                        Text('$totalCases'),
//                        Text('$totalCases'),
//                        Text('$totalCases'),
//                        Text('$totalCases'),
//                      ],
//                    )
                  ],
                )),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(GlobalAppConstants.dismiss),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          );
        });
  }

  showCountryData(BuildContext context) {
    return showCupertinoDialog(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              GlobalAppConstants.searchCountry,
              style: TextStyle(color: GlobalAppConstants.appMainColor),
            ),
            content: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text('Travel Advisories: '),
                        Text('Special Measures: '),
                        Text('Quarantines: '),
                        Text('Prepared Hospitals: '),
                        Text('Additional Info: '),
                      ],
                    ),
                  ],
                )),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(GlobalAppConstants.dismiss),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          );
        });
  }

  showHotspotData(BuildContext context) {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              'Hot Spots',
              style: TextStyle(color: GlobalAppConstants.appMainColor),
            ),
            content: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text('Total cases: '),
                        Text('New cases: '),
                        Text('Total deaths: '),
                        Text('Active cases: '),
                        Text('Total recovered: '),
                      ],
                    ),
//TODO: Use provider state management
//                    Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      mainAxisSize: MainAxisSize.max,
//                      children: <Widget>[
//                        Text('$totalCases'),
//                        Text('$totalCases'),
//                        Text('$totalCases'),
//                        Text('$totalCases'),
//                        Text('$totalCases'),
//                      ],
//                    )
                  ],
                )),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(GlobalAppConstants.dismiss),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          );
        });
  }
}