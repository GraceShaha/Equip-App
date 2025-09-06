import 'package:flutter/foundation.dart';
import 'item.dart';

class Cart with ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => List.unmodifiable(_items);

  bool isEmpty() {
    return _items.isEmpty;
  }
}