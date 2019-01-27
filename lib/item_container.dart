import 'dart:async';

import 'package:flutter/material.dart';
import 'item.dart';

class ItemContainer extends StatelessWidget {
  ItemContainer({this.item, this.onPressed});

  final Item item;
  final VoidCallback onPressed;
  
  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: AssetImage(item.config.asset),
      fit: BoxFit.cover,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            PointsValueIndicator(
              lastPressed: item.lastPressed,
              expectedFrequency: item.config.expectedFrequency,
            ),
            Container(
              padding: EdgeInsets.all(8),
              height: 52,
              color: Colors.black45,
              child: Text(
                item.config.name,
                style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white)
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PointsValueIndicator extends StatefulWidget {
  final DateTime lastPressed;
  final Duration expectedFrequency;

  PointsValueIndicator({Key key, this.lastPressed, this.expectedFrequency}) : super(key: key);

  @override
  _PointsValueIndicatorState createState() => _PointsValueIndicatorState();
}

class _PointsValueIndicatorState extends State<PointsValueIndicator> {

  var ratio = 0.0;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) => _recalculateRatio());
    super.initState();
  }

  void _recalculateRatio() {
    if (widget.lastPressed == null) return;
    setState(() {
      ratio = DateTime.now().difference(widget.lastPressed).inSeconds / widget.expectedFrequency.inSeconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: LinearProgressIndicator(
        backgroundColor: Colors.white54,
        value: ratio,
      ),
    );
  }
}