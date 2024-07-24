import 'package:flutter/material.dart';
import 'package:stripe_payment/domain/model/cart_list.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/order/order_viewmodel.dart';
import 'package:stripe_payment/widgets/icon_button.dart';

// ignore: must_be_immutable
class OrderContent extends StatelessWidget {
  OrderViewModel vm;
  List<CartList> checkoutList;
  OrderContent(this.vm, this.checkoutList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            'Resumen',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('asset/maps.png'),
                    ),
                    borderRadius: BorderRadius.circular(5)),
                width: 125,
                height: 100,
              ),
              const Padding(
                padding: EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Direccion de entrega:'),
                    Text(
                      'Condominio Motto',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.edit))
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15, top: 10),
          child: Text(
            'Items',
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          height: 280,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              children: List.generate(checkoutList.length, (index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(vm.concatImage(checkoutList[index].post)),
                            ),
                            borderRadius: BorderRadius.circular(2)),
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        checkoutList[index].quantity.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        checkoutList[index].post.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '\$${checkoutList[index].post.price}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
        const Divider(endIndent: 15, indent: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Subtotal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text('\$${vm.calculateSubtotalAmount(checkoutList)}'),
            )
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Costo de envio',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Text('\$35'),
            )
          ],
        ),
        const Divider(endIndent: 15, indent: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Total',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Text('\$${vm.calculateTotalAmount()}'),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Center(
            child: IconCustomBtn(
                icon: Icon(Icons.payment),
                txt: 'Pagar',
                onFcn: () {
                  String email = vm.getUser();
                  double amount = vm.calculateTotalAmount();
                  vm.initPayment(email, amount, context,checkoutList);
                }),
          ),
        )
      ],
    );
  }
}
