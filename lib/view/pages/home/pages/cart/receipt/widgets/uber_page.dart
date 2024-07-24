import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/domain/model/cart_list.dart';
import 'package:stripe_payment/domain/model/order.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/receipt/receipt_viewmodel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class UberReceiptPage extends StatelessWidget {
  const UberReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    ReceiptViewModel vm = Provider.of<ReceiptViewModel>(context);
    OrderData orderData =
        ModalRoute.of(context)?.settings.arguments as OrderData;
    List<CartList> items = orderData.items;
    DateTime dateTimeNow = DateTime.now();
    String shopName = 'Healthy and Simple Juices';
    String lastDigitCard = '6525';
    String pickUpAddress = '12170, James St. Holland, MI 49424';
    String deliverAddress = '12170, James St. Holland, MI 49424';
    String expirationCardDate = '02/26/24';

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.print, color: Colors.white),
              onPressed: () async {
                await vm.generatePdf(orderData, dateTimeNow, items,shopName,lastDigitCard,pickUpAddress,deliverAddress,expirationCardDate);
              },
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.black,
          title: Text(
            'Recibo',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Uber title and date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 40, top: 20),
                        child: Text('Uber',
                            style: TextStyle(
                                fontFamily: 'UberMove',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40, top: 25),
                        child: Text(vm.formatDate(dateTimeNow),
                            style: const TextStyle(
                                fontFamily: 'UberMove',
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 8)),
                      ),
                    ],
                  ),
                  const Divider(
                    endIndent: 40,
                    indent: 40,
                  ),
                  //Gracias por tu pedido
                  const Padding(
                    padding: EdgeInsets.only(left: 40, top: 8),
                    child: Text(
                      'Gracias por tu pedido, Ivan',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'UberMove',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //Este es el recibo de
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 5),
                    child: Text(
                      'Este es el recibo de ${shopName}',
                      style: const TextStyle(
                          fontFamily: 'UberMove',
                          fontWeight: FontWeight.w400,
                          fontSize: 8),
                    ),
                  ),
                  //Total
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                              fontFamily: 'UberMove',
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        ),
                        Text('${orderData.totalAmount} US\$',
                            style: TextStyle(
                                fontFamily: 'UberMove',
                                fontSize: 12,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  const Divider(
                    endIndent: 40,
                    indent: 40,
                    color: Colors.black54,
                  ),
                  //List of items
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Column(
                      children: List.generate(items.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(left: 3, right: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black54, width: .15)),
                                  child: Text(
                                    '${items[index].quantity}',
                                    style: TextStyle(
                                        fontFamily: 'UberMove', fontSize: 8),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  '${items[index].post.name}',
                                  style: TextStyle(
                                      fontFamily: 'UberMove', fontSize: 8),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${items[index].post.price} US\$',
                                      style: TextStyle(
                                          fontFamily: 'UberMove', fontSize: 8),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  const Divider(
                    endIndent: 40,
                    indent: 40,
                  ),
                  //Subtotal
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal',
                            style: TextStyle(
                                fontFamily: 'UberMove',
                                fontWeight: FontWeight.w700,
                                fontSize: 10)),
                        Text('${orderData.subtotalAmount} US\$',
                            style: const TextStyle(
                                fontFamily: 'UberMove',
                                fontWeight: FontWeight.w700,
                                fontSize: 8))
                      ],
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Cuota de servicio',
                                  style: TextStyle(
                                      fontFamily: 'UberMove', fontSize: 8)),
                              Text('3.06 US\$',
                                  style: TextStyle(
                                      fontFamily: 'UberMove', fontSize: 8))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tax',
                                  style: TextStyle(
                                      fontFamily: 'UberMove', fontSize: 8)),
                              Text('2.12 US\$',
                                  style: TextStyle(
                                      fontFamily: 'UberMove', fontSize: 8))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Fee',
                                  style: TextStyle(
                                      fontFamily: 'UberMove', fontSize: 8)),
                              Text('0.49 US\$',
                                  style: TextStyle(
                                      fontFamily: 'UberMove', fontSize: 8))
                            ],
                          ),
                        ],
                      )),
                  const Divider(
                    endIndent: 40,
                    indent: 40,
                  ),
                  //Payment title
                  const Padding(
                    padding: EdgeInsets.only(left: 40, top: 8),
                    child: Text(
                      'Pagos',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'UberMove',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //Payment details
                  Padding(
                    padding: EdgeInsets.only(left: 40, bottom: 12, right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 20, child: Image.asset('asset/visa.png')),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Visa••••$lastDigitCard',
                                  style: const TextStyle(
                                      fontFamily: 'UberMove',
                                      fontSize: 8,
                                      fontWeight: FontWeight.w700)),
                              Text(
                                expirationCardDate,
                                style: const TextStyle(
                                  fontFamily: 'UberMove',
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${orderData.totalAmount} US\$',
                                style: const TextStyle(
                                    fontFamily: 'UberMove',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    endIndent: 40,
                    indent: 40,
                  ),
                  //Payment Direction

                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      'Hiciste tu pedido de $shopName',
                      style: const TextStyle(
                          fontFamily: 'UberMove',
                          fontSize: 8,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40,top:5),
                    child: Row(  
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Se recolecto en',
                              style: TextStyle(
                                fontFamily: 'UberMove',
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              pickUpAddress,
                              style: const TextStyle(
                                fontFamily: 'UberMove',
                                fontWeight: FontWeight.w300,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Entregado a',
                                style: TextStyle(
                                  fontFamily: 'UberMove',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 8,
                                ),
                              ),
                              Text(
                                deliverAddress,
                                style: const TextStyle(
                                  fontFamily: 'UberMove',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
