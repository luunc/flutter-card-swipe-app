import 'package:flutter/material.dart';
import 'package:flutter_tinder/core/error_message.dart';

class ErrorNotification extends StatefulWidget {
  final Exception e;
  final Function action;

  const ErrorNotification(
    this.e,
    this.action, {
    Key key,
  }) : super(key: key);

  @override
  _ErrorNotificationState createState() => _ErrorNotificationState();
}

class _ErrorNotificationState extends State<ErrorNotification> {
  @override
  void didUpdateWidget(ErrorNotification oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.e != widget.e && widget.e != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            duration: Duration(days: 1),
            content: Text(getErrorMessage(widget.e)),
            action: SnackBarAction(
              onPressed: () {
                widget.action();
              },
              label: 'Try again',
            ),
          ),
        );
      });

      return;
    }

    if (oldWidget.e != null && widget.e == null)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scaffold.of(context).hideCurrentSnackBar();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
