import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  ItemContainer({this.name, this.expired, this.onPressed});

  final String name;
  final bool expired;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: expired ? Colors.blue : Colors.red,
      child: Center(
        child: Text(
          name,
          style: Theme.of(context)
              .textTheme
              .headline
              .apply(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      onPressed: onPressed,
    );
  }
}