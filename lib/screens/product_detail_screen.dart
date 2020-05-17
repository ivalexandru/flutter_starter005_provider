import "package:flutter/material.dart";
import "../providers/products.dart";
import "package:provider/provider.dart";

class ProductDetailScreen extends StatelessWidget {
//retrieve arg from the routing 'action':
  static const routeName = "./product-detail";
  @override
  Widget build(BuildContext context) {
    //extract the id passed from product_item.dart
    final productId = ModalRoute.of(context).settings.arguments as String;
    //ai acces la metoda findById definita in /providers/products, pt ca mixins:

    // listen:false => build/ get data ONCE, and DO NOT UPDATE when things change (better perf.)
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                //incadrez imaginea in Container:
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$ ${loadedProduct.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
