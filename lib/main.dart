import 'package:flutter/material.dart';
import 'item_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dang Home App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ItemPage(title: 'The Dangs'),
      debugShowCheckedModeBanner: false,
    );
  }
}
