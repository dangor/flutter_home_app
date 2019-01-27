import 'dart:async';

import 'package:flutter/material.dart';
import 'item.dart';
import 'how_long_ago.dart';

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
              color: Colors.black45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.config.name,
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    HowLongAgo.was(item.lastPressed),
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.white70),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PointsValueIndicator extends StatefulWidget {
  final DateTime lastPressed;
  final Duration expectedFrequency;

  PointsValueIndicator({Key key, this.lastPressed, this.expectedFrequency})
      : super(key: key);

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
      ratio = DateTime.now().difference(widget.lastPressed).inSeconds /
          widget.expectedFrequency.inSeconds;
    });
  }

  bool notNull(Object o) => o != null;

  String _ratioText() {
    if (ratio.floor() < 100) {
      return "x${ratio.floor().toString()}";
    } else {
      return "!!";
    }
  }

  Widget _multiplierIndicator() {
    if (ratio < 2) return null;

    return Transform.translate(
      offset: const Offset(4, -4),
      child: Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.lightBlueAccent, shape: BoxShape.circle),
        child: Text(
          _ratioText(),
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        LinearProgressIndicator(
          backgroundColor: Colors.white54,
          value: ratio,
        ),
        _multiplierIndicator(),
      ].where(notNull).toList(),
    );
  }
}
