import 'package:flutter/material.dart';

import 'item.dart';
import 'item_page.dart';
import 'user.dart';

/// Hardcoded config, future: move to DB, create admin UI
class HardcodedConfig {
  static List<ItemConfig> itemConfig = List.unmodifiable([
    ItemConfig("id0", "Feed Anton", "images/anton_fed.png", Duration(seconds: 12)),
    ItemConfig("id1", "Let Anton out", "images/patio_door.png", Duration(seconds: 8)),
    ItemConfig("id2", "Walk Anton", "images/walk_anton.png", Duration(minutes: 1)),
    ItemConfig("id3", "Glucosamine", "images/glucosamine.png", Duration(minutes: 1)),
    ItemConfig("id4", "Brush Anton's teeth", "images/brush_teeth.png", Duration(seconds: 30)),
    ItemConfig("id5", "Clip Anton's nails", "images/nail_clipper.png", Duration(seconds: 30)),
    ItemConfig("id6", "Clean litter box", "images/clean_litterbox.png", Duration(seconds: 12)),
    ItemConfig("id7", "Feed cats", "images/feed_cats.png", Duration(seconds: 12)),
  ]);

  static List<UserConfig> userConfig = List.unmodifiable([
    UserConfig("id0", "Angie", "images/angie_head.png", Colors.green),
    UserConfig("id1", "Brian", "images/brian_head.png", Colors.red),
  ]);

  static List<ItemPageConfig> pageConfig = List.unmodifiable([
    ItemPageConfig("id0", "First floor", ["id0", "id1", "id2", "id3", "id4", "id5"].toSet()),
    ItemPageConfig("id1", "Kitchen", ["id0"].toSet()),
    ItemPageConfig("id2", "Third floor", ["id6", "id7"].toSet()),
  ]);
}