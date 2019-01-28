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

  @override
  void initState() {
    _users.first.isActive = true;
    super.initState();
  }

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
      user.isActive = true;
      _users.where((u) => u != user).forEach((u) => u.isActive = false);
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
        actions: _users
            .map((user) => IconButton(
                  icon: Image.asset(user.config.asset),
                  onPressed: () => _onUserPressed(user),
                ))
            .toList(),
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PointsSummary(users: _users),
          Expanded(
            child: GridView.count(
                padding: EdgeInsets.all(16),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                crossAxisCount: 3,
                children: _items
                    .map((item) => ItemContainer(
                          item: item,
                          onPressed: () => _onItemPressed(item),
                        ))
                    .toList()),
          ),
        ],
      ),
    );
  }
}

class PointsSummary extends StatelessWidget {
  final List<User> users;

  const PointsSummary({Key key, this.users}) : super(key: key);

  int _getPoints(User user) {
    var lastWeek = DateTime.now().subtract(Duration(days: 7));
    return user.pointsEarned
        .where((points) => points.earnDate.isAfter(lastWeek))
        .fold(0, (acc, points) => acc + points.amount);
  }

  double _getUserPointsRatio(User user) {
    var totalPoints = users.fold(0, (acc, user) => acc + _getPoints(user));
    if (totalPoints == 0) return 0;
    return _getPoints(user) / totalPoints;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      padding: EdgeInsets.all(16),
      child: Table(
        columnWidths: {0: FixedColumnWidth(64), 1: FlexColumnWidth(1), 2: FixedColumnWidth(64)},
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: users
            .map(
              (user) => TableRow(
                    children: <Widget>[
                      Container(
                        child: Text(
                          user.config.name,
                          style: Theme.of(context).textTheme.subhead.copyWith(
                                color: user.isActive ? Colors.white : Colors.white54,
                                fontWeight: user.isActive ? FontWeight.bold : FontWeight.normal,
                              ),
                        ),
                      ),
                      LinearProgressIndicator(
                        value: _getUserPointsRatio(user),
                        valueColor: AlwaysStoppedAnimation(user.config.color.withAlpha(user.isActive ? 255 : 100)),
                        backgroundColor: Colors.transparent,
                      ),
                      Text(
                        _getPoints(user).toString(),
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: user.isActive ? Colors.white : Colors.white54),
                      ),
                    ],
                  ),
            )
            .toList(),
      ),
    );
  }
}
