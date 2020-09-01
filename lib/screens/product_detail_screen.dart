import 'package:flutter/material.dart';

// il ProductDetail screen riceve in input solo l'id del prodotto e poi recupera dallo state manager le informazioni di dettaglio
class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;
  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // product id
    return Scaffold(
      appBar: AppBar(
        title: Text(productId),
      ),
    );
  }
}
