import 'package:flutter/material.dart';
import 'item.dart';

class ItemContainer extends StatelessWidget {
  ItemContainer({this.item, this.onPressed});

  final Item item;
  final VoidCallback onPressed;

  double _calculateRatio() {
    if (item.lastPressed == null) {
      return 0;
    }

    return DateTime.now().difference(item.lastPressed).inSeconds / item.config.expectedFrequency.inSeconds;
  }

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
            Container(
              alignment: Alignment.centerRight,
              child: LinearProgressIndicator(
                backgroundColor: Colors.white54,
                value: _calculateRatio(),
              ),
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
