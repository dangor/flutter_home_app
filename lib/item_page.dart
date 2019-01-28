import 'package:flutter/material.dart';
import 'hardcoded_config.dart';
import 'item.dart';
import 'item_container.dart';
import 'user.dart';
import 'points.dart';

class ItemPage extends StatefulWidget {
  ItemPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  List<Item> _items = HardcodedConfig.itemConfig.map((config) => Item(config)).toList();
  List<User> _users = HardcodedConfig.userConfig.map((config) => User(config)).toList();

  List<User> _getActiveUsers() {
    return _users.where((user) => user.isActive).toList();
  }

  Color _getAppBarColor() {
    var activeUsers = _getActiveUsers();
    if (activeUsers.isEmpty) return Colors.blueGrey;
    if (activeUsers.length > 1) return Colors.yellow;
    return activeUsers.first.config.color;
  }
  
  void _onUserPressed(User user) {
    setState(() {
      user.isActive = !user.isActive;
    });
  }

  void _onItemPressed(Item item) {
    var now = DateTime.now();
    var activeUsers = _getActiveUsers();
    var points = 100;
    if (item.lastPressed != null) {
      points = ((now.difference(item.lastPressed).inSeconds / item.config.expectedFrequency.inSeconds) * 100).floor();
    }

    setState(() {
      item.lastPressed = now;
      activeUsers.forEach((user) => user.pointsEarned.add(Points(points, now)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _getAppBarColor(),
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
        actions: _users.map((user) => IconButton(
          icon: Image.asset(user.config.asset),
          onPressed: () => _onUserPressed(user),
        )).toList(),
        title: Text(widget.title),
      ),
      body: GridView.count(
          padding: EdgeInsets.all(16),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          crossAxisCount: 3,
          children: _items.map((item) {
            return ItemContainer(
              item: item,
              onPressed: () => _onItemPressed(item),
            );
          }).toList()),
    );
  }
}
