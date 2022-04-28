// import 'package:flutter/cupertino.dart';

// import 'package:flutter/material.dart';

// class CartItem {
//   final String id;
//   final String title;
//   final int quantity;
//   final double price;
//   CartItem(
//       {required this.id,
//       required this.title,
//       required this.quantity,
//       required this.price});
// }

// class Cart with ChangeNotifier {
//   late Map<String, CartItem> _items = {};
//   Map<String, CartItem> get items {
//     return {..._items};
//   }

//   int get ItemCount {
//     return _items.length;
//   }

//   double get totalAmount {
//     var total = 0.0;
//     _items.forEach((key, CartItem ) {
//       total += CartItem.price* CartItem.quantity;
//     })
//   }

//   void addItem(String productId, String price, String title) {
//     if (_items.containsKey(productId)) {
//       _items.update(
//           productId,
//           (existingcartItem) => CartItem(
//               id: existingcartItem.id,
//               title: existingcartItem.title,
//               quantity: existingcartItem.quantity + 1,
//               price: existingcartItem.price));
//     } else {
//       _items.putIfAbsent(
//           productId,
//           () => CartItem(
//                 id: DateTime.now().toString(),
//                 title: title,
//                 quantity: quantity,
//                 price: price,
//               ));
//     }
//     notifyListeners();
//   }
//   void removeItems(String productId)

//   {
// _items.remove(productId);
// notifyListeners();
//   }}

import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
      // ignore: dead_code
      if (_items[productId]!.quantity > 1) {
        _items.update(
            productId,
            (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity - 1,
                price: existingCartItem.price));
      } else {
        _items.remove(productId);
      }
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
