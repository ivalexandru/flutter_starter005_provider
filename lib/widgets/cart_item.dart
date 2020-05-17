import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    //vreau sa sterg itemul cu "swipe and remove"
    return Dismissible(
      key: ValueKey(id),
      //odata inceput swipe-ul, backgroundul va fi vizibil:
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      //vreau sa sterg cu swipe doar cand dau swipe intr-o anumita directie (default sunt ambele dir):
      //endToStart = de la dreapta la stanga
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        //'context' de dupa : (din dreapta)
        //se refera la context de mai sus din widget tree
        // aka cel de la build method
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Confirmati?"),
            content: Text("vrei sa stergi produsul din cos?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Nu"),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: Text("Da")),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        //nu vreau listener permanent, vreau doar prodId-ul
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              //vreau ca textul sa fie centrat in cerc:
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text('\$ $price'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$ ${(price * quantity)}'),
            //x as in multiplication sign:
            trailing: Text('$quantity  x'),
          ),
        ),
      ),
    );
  }
}
