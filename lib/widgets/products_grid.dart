import 'package:flutter/material.dart';
import '../widgets/product_item.dart';
import "package:provider/provider.dart";
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  //recieve _showOnlyFavorites prop:
  final bool showFav;
  ProductsGrid(this.showFav);

  @override
  Widget build(BuildContext context) {
    //daca produsele se schimba, rebuild
    //set up listener to fetch data
    //what type of data you wanna listen to? <Products>
    final productsData = Provider.of<Products>(context); // the whole obj

    //de unde .items? ai setat getter in /providers/products.dart
    //same for .favoriteItems, e pus ca getter
    final products = showFav
        ? productsData.favoriteItems
        : productsData.items; // just the list from the obj

    return GridView.builder(
      //if const => this part does not rebuild when the main method rebuilds
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      //fol 'create' cand INSTANTIEZI O CLASA (creezi un obj nou)
//CAND REFOLOSESTI UN OBJ EXISTENT(ca aici), foloseste .value
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i], //returns a single product item,
        //but it will do so multiple times, because it's inside the itemBuilder
        child: ProductItem(),
      ),
      //how the grid should be structured:
      //crossAxisCount = nr de coloane
      //crossAxisSpacing = space between columns
      //   3 /  2 = mai inalt decat e lat
      // mainAxisSpacing: space between the rows
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
