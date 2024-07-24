import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stripe_payment/view/pages/home/home_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/main/post_list_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/widgets/home_post_content.dart';

// ignore: must_be_immutable
class ShopList extends StatefulWidget {
  HomeViewModel vmHome;
  CartViewModel vmCart;
  PostListViewModel vmPost;
  ShopList(this.vmHome, this.vmCart, this.vmPost, {super.key});

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      widget.vmHome.getShopNameList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 190,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.vmHome.shopNamesList.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const CircleAvatar(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.vmHome.shopNamesList[index],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Ver mas',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 190,
                      child: HomePostContent(widget.vmPost, widget.vmCart,
                          widget.vmHome.shopNamesList[index])),
                ],
              );
            })));
  }
}
