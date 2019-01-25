import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  ItemContainer({this.name, this.asset, this.expired, this.onPressed});

  final String name;
  final String asset;
  final bool expired;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: AssetImage(asset),
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
                value: 0.9,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              height: 52,
              color: Colors.black45,
              child: Text(
                name,
                style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white)
              ),
            )
          ],
        ),
      ),
    );
  }
}
