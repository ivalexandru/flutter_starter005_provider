import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import "./cart_screen.dart";
import "../widgets/app_drawer.dart";

//pentru butonul PopupMenuButton
enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    //use this as a screen => Scaffold (because u need appbar..)
    return Scaffold(
      appBar: AppBar(
        title: Text("Magazinul Meu"),
        actions: <Widget>[
          //buton cu 3 puncte verticale, expansiv
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Doar favorite"),
                //value e util pt a afla ce item a ales utilizatorul
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text("Arata toate produsele"),
                value: FilterOptions.All,
              ),
            ],
          ),

          //vrem sa rerandam doar acest Badge, nu toata metoda build
          //asa ca fol Consumer in loc de Provider of
          //ch == child, pt a evita confuziile (here the IconButton)
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            //extras IconButton in afara functiei build
            //pt ca nu vreau sa il rerandez cand modific cosul (cart)
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),

      //pass _showO as prop, to display only fav or all
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
