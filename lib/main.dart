import 'package:flutter/material.dart';
import 'item_container.dart';
import 'item.dart';

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

class _ItemPageState extends State<ItemPage> {
  static var _itemConfig = [
    ItemConfig("id0", "Feed Anton", "images/anton_fed.png", Duration(seconds: 12)),
    ItemConfig("id1", "Let Anton out", "images/anton_fed.png", Duration(seconds: 8)),
    ItemConfig("id2", "Walk Anton", "images/anton_fed.png", Duration(minutes: 1)),
    ItemConfig("id3", "Glucosamine", "images/anton_fed.png", Duration(minutes: 1)),
    ItemConfig("id4", "Brush Anton's teeth", "images/anton_fed.png", Duration(seconds: 30)),
    ItemConfig("id5", "Clip Anton's nails", "images/anton_fed.png", Duration(seconds: 30)),
    ItemConfig("id6", "Clean litter box", "images/clean_litterbox.png", Duration(seconds: 12)),
    ItemConfig("id7", "Feed cats", "images/feed_cats.png", Duration(seconds: 12)),
  ];

  var _itemMap = Map.fromIterable(_itemConfig, key: (config) => config.id, value: (config) => Item(config));

  var _primaryUserActive = true;

  void _setPrimaryUserActive(bool active) {
    setState(() {
      _primaryUserActive = active;
    });
  }

  void _setPressed(String id) {
    setState(() {
      _itemMap[id].lastPressed = DateTime.now();
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
          children: _itemMap.values.map((item) {
            return ItemContainer(
              item: item,
              onPressed: () => _setPressed(item.config.id),
            );
          }).toList()),
    );
  }
}
