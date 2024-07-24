import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/domain/model/cart_list.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/order/order_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/order/widget/order_content.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<OrderViewModel>(context);
    //Receive data from the cartPage
    List<CartList> checkoutList =
        ModalRoute.of(context)?.settings.arguments as List<CartList>;

    return Scaffold(
        appBar: AppBar(),
        body: Stack(children: [
          StreamBuilder(
              stream: vm.responsePayment,
              builder: (context, snapshot) {
                final response = snapshot.data;
                if (response is Loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (response is Error) {
                  final data = response as Error;
                  Fluttertoast.showToast(
                      msg: 'Error: ${data.error}',
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 3);
                } else if (response is Success) {
                }
                return Container();
              }),
          OrderContent(vm, checkoutList)
        ]));
  }
}
