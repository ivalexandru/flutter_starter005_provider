import 'package:flutter/material.dart';
import "../screens/product_detail_screen.dart";
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //listen for stuff from providers and store them into product:
    final product = Provider.of<Product>(context, listen: false);

//give us access to the nearest provided obj of type Cart (acela din main.dart)
    final cart = Provider.of<Cart>(context, listen: false);
    //gridTile works good inside of grids
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            //only forward what you need (the id here):
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          //adaugi chestii in fata (stanga) titlului:
          leading: IconButton(
            icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).accentColor,
            onPressed: () {
              product.toggleFavoriteStatus();
            },
          ),

          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          //adaugi chestii dupa (in dreapta) titlului:
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              //.of() in general, nu doar pe Scaffold
              //stabileste o conexiune..
              //in cazul asta, cu cel mai apropiat widget
              // ce controleaza pagina pe care o vizualizam (din alt fisier aici..)
              //nu ar fi mers daca aveam Scaffold mai sus in widget tree
              //snackBar = infoPopup
              Scaffold.of(context)
                  .hideCurrentSnackBar(); // if there's a snackbar
              //it will be hidden before a new snackBar it shown
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'produsul a fost adaugat in cos',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () {
                      cart.removeSingleItemFromCart(product.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
