import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "/orders";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (data.error != null) {
              //error handling
            } else {
              return Consumer<Orders>(
                builder: (ctx, data, child) => ListView.builder(
                  itemBuilder: (ctx, i) => OrderItem(data.orders[i]),
                  itemCount: data.orders.length,
                ),
              );
            }
          }
        },
      ),
      //  _isLoading
      //     ? Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     : ListView.builder(
      //         itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
      //         itemCount: orderData.orders.length,
      //       ),
      drawer: AppDrawer(),
    );
  }
}
