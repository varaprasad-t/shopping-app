import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cart = [];

  List<Map<String, dynamic>> get cart => _cart;

  void addProduct(Map<String, dynamic> product) {
    int index = _cart.indexWhere((item) => item['id'] == product['id']);

    int qtyToAdd = product['qty'] ?? 1;
    double priceToAdd = product['price'] ?? 0.0;

    if (index != -1) {
      // Update quantity and price
      _cart[index]['qty'] = (_cart[index]['qty'] ?? 1) + qtyToAdd;
      _cart[index]['price'] = (_cart[index]['price'] ?? 0.0) + priceToAdd;
    } else {
      _cart.add({...product, 'qty': qtyToAdd, 'price': priceToAdd});
    }

    notifyListeners();
  }

  void removeProduct(Map<String, dynamic> product) {
    _cart.removeWhere((item) => item['id'] == product['id']);
    notifyListeners();
  }
}
