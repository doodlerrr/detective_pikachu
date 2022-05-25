// @dart=2.9
import 'package:detective_pikachu/model/favorite_list_models.dart';
import 'package:flutter/foundation.dart';

class FavoritePageModel extends ChangeNotifier{
  FavoriteListModel _favoritelist;
  final List<int> _itemIds = [];

  FavoriteListModel get favoritelist => _favoritelist;

  set favoritelist(FavoriteListModel newList) {
    _favoritelist = newList;
    notifyListeners();
  }

  List<Item> get items =>
      _itemIds.map((id) => _favoritelist.getById(id)).toList();

  void add(Item item) {
      _itemIds.add(item.id);
      notifyListeners();
    }

  void remove(Item item) {
  _itemIds.remove(item.id);
    notifyListeners();
  }


}