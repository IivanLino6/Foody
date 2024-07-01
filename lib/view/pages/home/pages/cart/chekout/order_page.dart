import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/domain/model/cart_list.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/chekout/order_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/chekout/widget/order_content.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<OrderViewModel>(context);
    //Receive data from the cartPage
    List<CartList> checkoutList =
        ModalRoute.of(context)?.settings.arguments as List<CartList>;

    return Scaffold(appBar: AppBar(), body: OrderContent(vm, checkoutList));
  }
}
