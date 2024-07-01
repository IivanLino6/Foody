import 'package:flutter/material.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/widgets/cart_items.dart';
import 'package:stripe_payment/widgets/icon_button.dart';

// ignore: must_be_immutable
class CartPageContent extends StatelessWidget {

  CartViewModel vm;
  CartPageContent(this.vm);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          width: double.infinity, // Ajusta según tus necesidades
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45)) // Esquinas redondeadas
              ),
          child: Stack(
            children: [
              vm.cartList.isNotEmpty
                  ? Positioned(
                      child: ListView.builder(
                          itemCount: vm.cartList.length,
                          itemBuilder: (context, index) {
                            return CartItem(vm.cartList[index].post, vm, index);
                          }))
                  : const Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_basket,
                          color: Colors.grey,
                        ),
                        Text(
                          'Cart is empty',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ],
                    )),
              //TotalAmount
              Positioned(
                top: 570,
                child: Container(
                  decoration: BoxDecoration(
                    
                    color: Colors.black, // Set background color
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        offset: const Offset(0, 3), // Shadow offset
                        blurRadius: 5.0, // Shadow blur radius
                        spreadRadius: 2.0, // Shadow spread radius
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text('Subtotal:',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            '${'\$ ${vm.totalAmount}'}', // Interpolación de cadenas
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: IconCustomBtn(
                                    color: Colors.white,
                                    txtColor: Colors.black,
                                    widht: 140,
                                    icon: const Icon(
                                      Icons.payment,
                                      color: Colors.black,
                                    ),
                                    txt: 'Continuar',
                                    onFcn: () {
                                      // String email = vm.getUser();
                                      //double amount =vm.calculateTotalAmount();
                                      // vmStripe.initPayment(email, amount, context);
                                      Navigator.pushNamed(context, 'OrderPage',
                                          arguments: vm.cartList);
                                    }),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    ]);
  }
}
