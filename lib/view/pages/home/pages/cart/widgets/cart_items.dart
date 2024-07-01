import 'package:flutter/material.dart';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart';
import 'package:stripe_payment/widgets/custom_container.dart';

class CartItem extends StatelessWidget {
  Post post;
  CartViewModel vm;
  final int index;
  CartItem(this.post, this.vm, this.index);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              //White background
              Container(
            height: 110,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(25.0), // Set radius for rounded corners
              color: Colors.white, // Set background color
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1), // Shadow color
                  offset: Offset(0, 3), // Shadow offset
                  blurRadius: 5.0, // Shadow blur radius
                  spreadRadius: 2.0, // Shadow spread radius
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        //Image
                        Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(vm.concatImage(post)), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(
                            10.0), // Set radius for rounded corners
                        color: Colors.white, // Set background color
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1), // Shadow color
                            offset: Offset(0, 3), // Shadow offset
                            blurRadius: 5.0, // Shadow blur radius
                            spreadRadius: 2.0, // Shadow spread radius
                          ),
                        ],
                      ),
                      width: 100,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Expanded(
                        child: Text(
                          post.description,
                          maxLines: 3,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      Text(post.price)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      //Actions Buttons
      Positioned(
          top: 85,
          right: 15,
          child: Row(
            children: [
              //Delete Button
              IconButton(
                  onPressed: () {
                    vm.decrementCounter(post);
                  },
                  icon: Icon(Icons.remove_circle)),
              MyContainer(
                  height: 30,
                  width: 30,
                  child: Center(
                      child: Text(vm.cartList[index].quantity.toString()))),
              IconButton(
                  onPressed: () {
                    vm.incrementCounter(post);
                  },
                  icon: Icon(Icons.add_circle)),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Ajusta el radio según tus preferencias
                      ),
                      backgroundColor: Colors.red,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 12,
                      ),
                      onPressed: () {
                        vm.removeFromCart(post);
                      }),
                ),
              ),
            ],
          ))
    ]);
  }
}
