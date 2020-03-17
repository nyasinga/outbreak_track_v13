import 'package:flutter/cupertino.dart';
import 'package:outbreak_tracker/HomePage.dart';

void main() => runApp(OutbreakTrackerApp());

class OutbreakTrackerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(

      ),
      title: 'Outbreak Tracker',
      home: HomePage(),
    );
  }
}
