import 'package:flutter/material.dart';
import 'hardcoded_config.dart';
import 'item.dart';
import 'item_container.dart';
import 'user.dart';
import 'points.dart';
import 'shared_pref.dart';

class ItemPageConfig {
  final String id;
  final String title;
  final Set<String> itemIds;

  ItemPageConfig(this.id, this.title, this.itemIds);
}

class ItemPage extends StatefulWidget {
  ItemPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Map<String, Item> _items = Map.fromIterable(HardcodedConfig.itemConfig,
      key: (itemConfig) => itemConfig.id, value: (itemConfig) => Item(itemConfig));
  List<User> _users = HardcodedConfig.userConfig.map((config) => User(config)).toList();
  ItemPageConfig _activePage = HardcodedConfig.pageConfig[0];

  @override
  void initState() {
    _users.first.isActive = true;
    _loadFromSharedPref();
    super.initState();
  }

  void _loadFromSharedPref() async {
    // items
    for (var item in _items.values) {
      var lastPressed = await SharedPref.getLastPressed(item.config.id);
      setState(() {
        item.lastPressed = lastPressed;
      });
    }

    // users
    for (var user in _users) {
      var pointsEarned = await SharedPref.getPointsEarned(user.config.id);
      setState(() {
        user.pointsEarned = pointsEarned;
      });
    }
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
    var pointsAmount = 100;
    if (item.lastPressed != null) {
      pointsAmount =
          ((now.difference(item.lastPressed).inSeconds / item.config.expectedFrequency.inSeconds) * 100).floor();
    }

    var points = Points(pointsAmount, now, item.config.id);

    setState(() {
      item.secondToLastPressed = item.lastPressed;
      item.lastPressed = now;
      activeUsers.forEach((user) => user.pointsEarned.add(points));
    });

    SharedPref.setLastPressed(item.config.id, now);
    activeUsers.forEach((user) => SharedPref.setPointsEarned(user.config.id, user.pointsEarned));
  }

  void _onUndoPressed(Item item) {
    var thirtySecondsAgo = DateTime.now().subtract(Duration(seconds: 30));

    setState(() {
      item.lastPressed = item.secondToLastPressed;
      _users.forEach((user) => user.pointsEarned
          .removeWhere((points) => points.itemId == item.config.id && points.earnDate.isAfter(thirtySecondsAgo)));
    });

    if (item.lastPressed != null) {
      SharedPref.setLastPressed(item.config.id, item.lastPressed);
    }
    _users.forEach((user) => SharedPref.setPointsEarned(user.config.id, user.pointsEarned));
  }

  void _onPageConfigPressed(ItemPageConfig pageConfig) {
    setState(() {
      _activePage = pageConfig;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _getAppBarColor(),
        leading: PopupMenuButton(
          onSelected: _onPageConfigPressed,
          itemBuilder: (BuildContext context) => HardcodedConfig.pageConfig
              .map(
                (pageConfig) => PopupMenuItem(
                      child: Text(
                        pageConfig.title,
                      ),
                      value: pageConfig,
                    ),
              )
              .toList(),
        ),
        actions: _users
            .map((user) => IconButton(
                  icon: Image.asset(user.config.asset),
                  onPressed: () => _onUserPressed(user),
                ))
            .toList(),
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
          Container(
            alignment: AlignmentDirectional.bottomCenter,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image(
                    fit: BoxFit.fitWidth,
                    alignment: AlignmentDirectional.bottomCenter,
                    image: AssetImage(_getActiveUsers().first.config.bgAsset),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    alignment: AlignmentDirectional.topCenter,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0, -0.9),
                        end: Alignment(0, -0.7),
                        colors: [
                          Colors.black,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PointsSummary(users: _users, title: _activePage.title),
              Expanded(
                child: GridView.count(
                    padding: EdgeInsets.all(16),
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    crossAxisCount: 3,
                    children: _activePage.itemIds
                        .map((id) => _items[id])
                        .map((item) => ItemContainer(
                              item: item,
                              onPressed: () => _onItemPressed(item),
                              onUndo: () => _onUndoPressed(item),
                            ))
                        .toList()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PointsSummary extends StatelessWidget {
  final List<User> users;
  final String title;

  const PointsSummary({Key key, this.users, this.title}) : super(key: key);

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
      color: Colors.white12,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "$title (past 7 days)",
              style: Theme.of(context).textTheme.body1.copyWith(color: Colors.blueGrey),
              textAlign: TextAlign.left,
            ),
          ),
          Table(
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
        ],
      ),
    );
  }
}
