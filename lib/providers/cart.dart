import 'package:flutter/cupertino.dart';

class CartItem {
  //def model pt cos cump.
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  //mapez fiecare CartItem cu id-ul produsului
  // (un obj CartItem va avea id diferit de id-ul produsului)
  //String, pt ca id-ul meu e type S..
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

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      //itemul exista deja in cos, mod cantitatea
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          //va pastra toate prop itemului existent, mod doar cantitatea
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      //cheia nu exista, deci instantiez un nou obj CartItem cu prodId
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

//asignasem mai sus productId ca si key on a map
// pe maps, avem metoda remove care cere o cheie.
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItemFromCart(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    //sterg o bucata a produsului, daca am acelasi produs de mai multe ori..
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      //altminteri sterg produsul
      _items.remove(productId);
    }
    notifyListeners();
  }

//odata ce a facut comanda:
  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
