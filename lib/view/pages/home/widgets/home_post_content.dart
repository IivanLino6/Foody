import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:stripe_payment/view/pages/home/home_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/main/post_list_viewmodel.dart';

class HomePostContent extends StatefulWidget {
  PostListViewModel vm;
  CartViewModel vmCart;

  HomePostContent(this.vm, this.vmCart, {super.key});

  @override
  State<HomePostContent> createState() => _HomePostContentState();
}

class _HomePostContentState extends State<HomePostContent> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.vm.getPosts(),
        builder: ((context, snapshot) {
          final response = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No Info',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          if (response is Error) {
            final data = response as Error;
            return Center(
              child: Text('Error: ${data.error}'),
            );
          }
          final postList = response as Success<List<Post>>;
          return ListView.builder(
            key: PageStorageKey<String>('list_view'),    //Keep the same position on ListView when the user add an item
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: postList.data.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 50),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.1), // color de la sombra con opacidad
                              spreadRadius: 2, // qué tanto se expande la sombra
                              blurRadius: 7, // radio del desenfoque
                              offset: const Offset(
                                  3, 3), // desplazamiento de la sombra (x, y)
                            ),
                          ],
                        ),
                        height: 130,
                        width: 140,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Text(
                                postList.data[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  postList.data[index].description,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
                              ),
                              Text(postList.data[index].price)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        left: 20,
                        child: Image.network(
                          widget.vm.concatImage(postList.data[index]),
                          height: 100,
                          width: 120,
                        )),
                    Positioned(
                      top: 130,
                      right: 20,
                      child: //Add Button
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
                              backgroundColor: Colors.white,
                              child: Icon(
                                widget.vmCart.isSelected(postList.data[index])
                                    ? Icons.check
                                    : Icons.add,
                                size: 16,
                              ),
                              onPressed: () {
                                widget.vmCart.addToCart(postList.data[index]);
                                widget.vmCart
                                    .selectedItems(postList.data[index]);
                              }),
                        ),
                      ),
                    )
                  ],
                );
              });
        }));
  }
}
