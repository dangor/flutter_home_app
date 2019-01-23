import 'package:flutter/material.dart';
import 'item_container.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ItemPage(title: '1st floor'),
    );
  }
}

class ItemPage extends StatefulWidget {
  ItemPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ItemPageState createState() => _ItemPageState();
}

class Item {
  final String name;
  bool expired = false;

  Item(this.name);
}

class _ItemPageState extends State<ItemPage> {
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
      }).expired = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton(
          itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  child: Text("Admin"),
                ),
                const PopupMenuItem(
                  child: Text("1st floor"),
                ),
              ],
        ),
        title: Text(widget.title),
      ),
      body: GridView.count(
          padding: EdgeInsets.all(16),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          crossAxisCount: 3,
          children: _items.map((item) {
            return ItemContainer(
              name: item.name,
              expired: item.expired,
              onPressed: () {
                _setPressed(item);
              },
            );
          }).toList()),
    );
  }
}
