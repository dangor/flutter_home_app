import 'package:flutter/material.dart';

import 'item.dart';
import 'item_page.dart';
import 'user.dart';

/// Hardcoded config, future: move to DB, create admin UI
class HardcodedConfig {
  static List<ItemConfig> itemConfig = List.unmodifiable([
    ItemConfig("dogfood", "Feed Anton", "images/anton_fed.png", Duration(hours: 12)),
    ItemConfig("dogpee", "Let Anton out", "images/patio_door.png", Duration(hours: 10)),
    ItemConfig("dogwalk", "Walk Anton", "images/walk_anton.png", Duration(days: 1)),
    ItemConfig("glucosamine", "Glucosamine", "images/glucosamine.png", Duration(days: 1)),
    ItemConfig("dogteeth", "Brush Anton's teeth", "images/brush_teeth.png", Duration(days: 7)),
    ItemConfig("dognails", "Clip Anton's nails", "images/nail_clipper.png", Duration(days: 30)),
    ItemConfig("litterbox", "Clean litter box", "images/clean_litterbox.png", Duration(hours: 12)),
    ItemConfig("catfood", "Feed cats", "images/feed_cats.png", Duration(hours: 12)),
    ItemConfig("guido", "Guido", "TODO", Duration(days: 2)),
    ItemConfig("vacuum1f", "Vacuum 1st floor", "TODO", Duration(days: 7)),
    ItemConfig("plants", "Water plants", "TODO", Duration(days: 7)),
    ItemConfig("jade", "Water jade plant", "TODO", Duration(days: 21)),
    ItemConfig("probiotic", "Probiotic", "TODO", Duration(days: 1)),
    ItemConfig("rinseaid", "Rinse Aid", "TODO", Duration(days: 30)),
    ItemConfig("sponge", "Replace Sponge", "TODO", Duration(days: 30)),
    ItemConfig("launderClothes", "Laundry - Clothes", "TODO", Duration(days: 4)),
    ItemConfig("launderLinens", "Laundry - Linens", "TODO", Duration(days: 14)),
    ItemConfig("vacuum3f", "Vacuum 3rd floor", "TODO", Duration(days: 7)),
    ItemConfig("rundishwasher", "Run dishwasher", "TODO", Duration(days: 4)),
    ItemConfig("emptydishwasher", "Empty dishwasher", "TODO", Duration(days: 4)),
  ]);

  static List<UserConfig> userConfig = List.unmodifiable([
    UserConfig("user0", "Angie", "images/angie_head.png", Colors.green),
    UserConfig("user1", "Brian", "images/brian_head.png", Colors.red),
  ]);

  static List<ItemPageConfig> pageConfig = List.unmodifiable([
    ItemPageConfig("page0", "First floor", ["dogpee", "dogfood", "glucosamine", "dogwalk", "dogteeth", "dognails", "guido", "vacuum1f"].toSet()),
    ItemPageConfig("page1", "Kitchen", ["rundishwasher", "emptydishwasher", "rinseaid", "probiotic", "plants", "jade", "sponge"].toSet()),
    ItemPageConfig("page2", "Third floor", ["litterbox", "catfood", "vacuum3f", "launderClothes", "launderLinens"].toSet()),
  ]);
}