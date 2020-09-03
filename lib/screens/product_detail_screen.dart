import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

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
    // listen: false, il widget non viene rigenerato se cambiano i dati della lista prodotti, questo widget
    // è interessato solo al dettaglio di un prodotto e non ha interesse al cambiamento degli elementi della lista
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
