import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/widgets/cart_page.content.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartViewModel _vm;
   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm = Provider.of<CartViewModel>(context, listen: false);
      _vm.calculateTotalAmount();
    });
  }
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CartViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Cart'),
        ),
        body: CartPageContent(vm));
  }
}
