import 'package:flutter/cupertino.dart';

class ProgressBarHelper {
  BuildContext context;

  ProgressBarHelper(this.context);

  void showProgressBar() => showCupertinoModalPopup<void>(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return Center(
          child: CupertinoActivityIndicator(
            animating: true,
            radius: 20,
          ),
        );
      }
  );
}