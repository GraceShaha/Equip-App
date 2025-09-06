import 'package:flutter/foundation.dart';
import 'item.dart';

class Cart with ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => List.unmodifiable(_items);

  void addItem(Item item) {
    if (!_items.contains(item)) {
      _items.add(item);
      notifyListeners();
    }
  }

  void removeItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  bool contains(Item item) {
    return _items.contains(item);
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool isEmpty() {
    return _items.isEmpty;
  }
}