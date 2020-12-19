import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacucha_app_v2/bloc/timer/bloc.dart';

import '../../../constants.dart';

class TimerButton extends StatelessWidget {
  final Widget button;

  TimerButton({Key key, this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
      child: Ink(
        decoration: ShapeDecoration(
          color: secondaryColorDark,
          shape: CircleBorder(),
        ),
        child: button,
      ),
    );
  }
}

class PauseButton extends StatelessWidget {
  final Function onPressed;

  PauseButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimerButton(
      button: IconButton(icon: Icon(Icons.pause), color: Colors.lightBlue[300], onPressed: onPressed),
    );
  }
}

class PlayButton extends StatelessWidget {
  final Function onPressed;

  PlayButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimerButton(
      button: IconButton(
        icon: Icon(Icons.play_arrow),
        color: Colors.lightGreen[300],
        onPressed: onPressed,
      ),
    );
  }
}

class StopButton extends StatelessWidget {
  final Function onPressed;

  StopButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimerButton(
      button: IconButton(
        icon: Icon(Icons.stop),
        color: Colors.red[300],
        onPressed: onPressed,
      ),
    );
  }
}
