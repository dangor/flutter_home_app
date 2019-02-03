import 'package:flutter/material.dart';

import 'item.dart';
import 'item_page.dart';
import 'user.dart';

/// Hardcoded config, future: move to DB, create admin UI
class HardcodedConfig {
  static List<ItemConfig> itemConfig = List.unmodifiable([
    ItemConfig("item0", "Feed Anton", "images/anton_fed.png", Duration(hours: 12)),
    ItemConfig("item1", "Let Anton out", "images/patio_door.png", Duration(hours: 10)),
    ItemConfig("item2", "Walk Anton", "images/walk_anton.png", Duration(days: 1)),
    ItemConfig("item3", "Glucosamine", "images/glucosamine.png", Duration(days: 1)),
    ItemConfig("item4", "Brush Anton's teeth", "images/brush_teeth.png", Duration(days: 7)),
    ItemConfig("item5", "Clip Anton's nails", "images/nail_clipper.png", Duration(days: 30)),
    ItemConfig("item6", "Clean litter box", "images/clean_litterbox.png", Duration(hours: 12)),
    ItemConfig("item7", "Feed cats", "images/feed_cats.png", Duration(hours: 12)),
  ]);

  static List<UserConfig> userConfig = List.unmodifiable([
    UserConfig("user0", "Angie", "images/angie_head.png", Colors.green),
    UserConfig("user1", "Brian", "images/brian_head.png", Colors.red),
  ]);

  static List<ItemPageConfig> pageConfig = List.unmodifiable([
    ItemPageConfig("page0", "First floor", ["item1", "item0", "item3", "item2", "item4", "item5"].toSet()),
    ItemPageConfig("page1", "Kitchen", ["item0"].toSet()),
    ItemPageConfig("page2", "Third floor", ["item6", "item7"].toSet()),
  ]);
}