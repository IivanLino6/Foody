import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/domain/model/order.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/receipt/receipt_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/receipt/widgets/receipt_content.dart';


class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    OrderData orderData = ModalRoute.of(context)?.settings.arguments as OrderData;
    ReceiptViewModel vm = Provider.of<ReceiptViewModel>(context);
    return ReceiptContent(vm,orderData);
  }
}