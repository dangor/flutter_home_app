import 'dart:ui';
import 'points.dart';

class User {
  final UserConfig config;
  List<Points> pointsEarned = [];
  bool isActive = false;

  User(this.config);
}

class UserConfig {
  final String id;
  final String name;
  final String asset;
  final String bgAsset;
  final Color color;

  UserConfig(this.id, this.name, this.asset, this.bgAsset, this.color);
}