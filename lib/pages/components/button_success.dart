import 'package:flutter/material.dart';

class ButtonSuccess extends StatelessWidget {
  ButtonSuccess({Key key, this.text, this.onPressed});

  String text;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Row(
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.green[200],
      onPressed: onPressed,
    );
  }
}
