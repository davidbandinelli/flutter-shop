import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

// per gestire uno spinner mentre è in corso la richiesta http questo è il modo più elegante e leggero
// perchè lo widget può rimanere stateless utilizzando il FutureBuilder ed il Consumer
// nel codice commentato lo stato di caricamento va gestito a mano e quindi il widget deve diventare stateful
// attenzione al fatto che il metodo Build causa la chiamata http, quindi se un cambio di stato provoca il "redraw"
// di questo widget, verrà ripetuta la chiamata http.
// per evitarlo è necessario trasformarlo di nuovo in stateful e fare la chiamata nell'init state in una funzione e
// assegnare al future builder il risultato della funzione
class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _ordersFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('building orders');
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              // ...
              // Do error handling stuff
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

// class OrdersScreen extends StatelessWidget {
//   static const routeName = '/orders';

//   @override
//   Widget build(BuildContext context) {
//     print('building orders');
//     // final orderData = Provider.of<Orders>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Orders'),
//       ),
//       drawer: AppDrawer(),
//       body: FutureBuilder(
//         future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
//         builder: (ctx, dataSnapshot) {
//           if (dataSnapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else {
//             if (dataSnapshot.error != null) {
//               // ...
//               // Do error handling stuff
//               return Center(
//                 child: Text('An error occurred!'),
//               );
//             } else {
//               return Consumer<Orders>(
//                 builder: (ctx, orderData, child) => ListView.builder(
//                   itemCount: orderData.orders.length,
//                   itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
//                 ),
//               );
//             }
//           }
//         },
//       ),
//     );
//   }
// }

// class OrdersScreen extends StatefulWidget {
//   static const routeName = '/orders';

//   @override
//   _OrdersScreenState createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
//   var _isLoading = false;

//   // chiamata al backend per recuperare gli ordini
//   // @override
//   // void initState() {
//   //   Future.delayed(Duration.zero).then((_) async {
//   //     setState(() {
//   //       _isLoading = true;
//   //     });
//   //     await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
//   //     setState(() {
//   //       _isLoading = false;
//   //     });
//   //   });
//   //   super.initState();
//   // }

//   // con listen: false funziona anche in questo modo senza la Future.delayed
//   @override
//   void initState() {
//     _isLoading = true;
//     Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
//       setState(() {
//         _isLoading = false;
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final orderData = Provider.of<Orders>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Orders'),
//       ),
//       drawer: AppDrawer(),
//       body: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: orderData.orders.length,
//               itemBuilder: (ctx, i) => OrderItem(orderData.orders[i])),
//     );
//   }
// }
