import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:materialcalculator/model/inventorymodel.dart';

class InventoryProvider extends ChangeNotifier {
  final List<InventoryItem> _items = [
    InventoryItem(name: "Cement", quantity: 10000000, unit: "bags"),
    InventoryItem(name: "Bricks", quantity: 10000000, unit: "pieces"),
    InventoryItem(name: "Tiles", quantity: 10000000, unit: "boxes"),
  ];

  List<Map<String, dynamic>> _usedItems = [];

  List<InventoryItem> get items => _items;
  List<Map<String, dynamic>> get usedItems => _usedItems;

  void addItem(String name, double quantity, String unit) {
    bool itemExists = false;

    for (int i = 0; i < _items.length; i++) {
      if (_items[i].name == name) {
        _items[i].quantity += quantity;
        itemExists = true;
        break;
      }
    }

    if (!itemExists) {
      _items.add(InventoryItem(name: name, quantity: quantity, unit: unit));
    }

    notifyListeners();
  }

  void useItem(String name, double quantity) {
    bool itemFound = false;

    _items.map((item) {
      if (item.name == name && item.quantity >= quantity) {
        item.quantity -= quantity;
        _usedItems.add({
          'name': name,
          'quantity': quantity,
          'unit': item.unit,
          'timestamp': DateTime.now().toString(),
        });

        itemFound = true;
      }
      return item;
    }).toList();

    if (itemFound) {
      _saveUsedHistory();
      notifyListeners();
    }
  }

  void deleteUsedItem(int index) {
    _usedItems.removeAt(index);
    _saveUsedHistory();
    notifyListeners();
  }

  void clearUsedHistory() {
    _usedItems.clear();
    _saveUsedHistory();
    notifyListeners();
  }

  void resetStock() {
    final List<Map<String, dynamic>> defaultStock = [
      {"name": "Cement", "quantity": 10000000},
      {"name": "Bricks", "quantity": 10000000},
      {"name": "Tiles", "quantity": 10000000},
    ];

    for (int i = 0; i < _items.length; i++) {
      for (int j = 0; j < defaultStock.length; j++) {
        if (_items[i].name == defaultStock[j]["name"]) {
          _items[i].quantity = defaultStock[j]["quantity"] as double;
        }
      }
    }

    notifyListeners();
  }

  Future<void> _saveUsedHistory() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('usedHistory', jsonEncode(_usedItems));
  }

  Future<void> _loadUsedHistory() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('usedHistory');

    if (savedData != null) {
      _usedItems = List<Map<String, dynamic>>.from(jsonDecode(savedData));
      notifyListeners();
    }
  }
}