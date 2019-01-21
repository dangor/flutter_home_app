import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ButtonPage(title: '1st floor'),
    );
  }
}

class ButtonPage extends StatefulWidget {
  ButtonPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class Item {
  final String name;
  bool pressed = false;

  Item(this.name);
}

class _ButtonPageState extends State<ButtonPage> {
  var _items = [
    Item("Feed Anton"),
    Item("Let Anton out"),
    Item("Walk Anton"),
    Item("Glucosamine"),
    Item("Brush Anton's teeth"),
    Item("Clip Anton's nails"),
  ];

  void _setPressed(Item item) {
    setState(() {
      _items.firstWhere((_item) {
        return _item.name == item.name;
      }).pressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
          padding: EdgeInsets.all(16),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          crossAxisCount: 3,
          children: _items.map((item) {
            return MaterialButton(
              color: item.pressed ? Colors.blue : Colors.red,
              child: Center(
                child: Text(
                  item.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .apply(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () {
                _setPressed(item);
              },
            );
          }).toList()),
    );
  }
}
