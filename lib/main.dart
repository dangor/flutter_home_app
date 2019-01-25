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
  final String asset;
  bool expired = false;

  Item(this.name, this.asset);
}

class _ItemPageState extends State<ItemPage> {
  var _items = [
    Item("Feed Anton", "images/anton_fed.png"),
    Item("Let Anton out", "images/anton_fed.png"),
    Item("Walk Anton", "images/anton_fed.png"),
    Item("Glucosamine", "images/anton_fed.png"),
    Item("Brush Anton's teeth", "images/anton_fed.png"),
    Item("Clip Anton's nails", "images/anton_fed.png"),
    Item("Clean litter box", "images/clean_litterbox.png"),
    Item("Feed cats", "images/feed_cats.png"),
  ];

  var _primaryUserActive = true;

  void _setPrimaryUserActive(bool active) {
    setState(() {
      _primaryUserActive = active;
    });
  }

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
        backgroundColor: _primaryUserActive ? Colors.green : Colors.red,
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
        actions: <Widget>[
          IconButton(
            icon: Image.asset("images/angie_head.png"),
            onPressed: () => _setPrimaryUserActive(true),
          ),
          IconButton(
            icon: Image.asset("images/brian_head.png"),
            onPressed: () => _setPrimaryUserActive(false),
          ),
        ],
        title: Text(widget.title),
      ),
      body: GridView.count(
        padding: EdgeInsets.all(8),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
          crossAxisCount: 3,
          children: _items.map((item) {
            return ItemContainer(
              name: item.name,
              asset: item.asset,
              expired: item.expired,
              onPressed: () {
                _setPressed(item);
              },
            );
          }).toList()),
    );
  }
}
