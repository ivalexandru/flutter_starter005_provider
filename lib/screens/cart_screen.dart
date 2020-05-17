import 'package:flutter/material.dart';
//only insterested in Cart from that file:
import '../providers/cart.dart' show Cart;
import "package:provider/provider.dart";
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context); // gives access to the Cart
    return Scaffold(
      appBar: AppBar(
        title: Text("Cos cumparaturi"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  //butonul si suma sunt aliniata in partea dreapta, textul in stanga:
                  //aka ce e inainte de Spacer e aliniat la stanga
                  //apoi ce vine dupa la dreapta
                  Spacer(),

                  Chip(
                    label: Text(
                      '\$ ${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text("cumpara amu"),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clearCart();
                    },
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          //expanded makes sure we take as much space as is left in this column we're in
          //itemCount e getter definit in 'modelul' meu (provider aici)
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                //.values.toList() to get the values out of the Map
                cart.items.values.toList()[i].id,
                cart.items.keys
                    .toList()[i], //pass the key (that is the productId)
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}
