import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/domain/model/food_categories.dart';
import 'package:stripe_payment/domain/model/promotions.dart';
import 'package:stripe_payment/view/pages/home/home_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/main/post_list_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/widgets/home_post_content.dart';
import 'package:stripe_payment/view/pages/home/widgets/shop_list.dart';
import 'package:stripe_payment/widgets/icon_button.dart';
import 'package:stripe_payment/widgets/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    
  }

  @override
  Widget build(BuildContext context) {
    HomeViewModel vmHome = Provider.of<HomeViewModel>(context);
    PostListViewModel vm = Provider.of<PostListViewModel>(context);
    CartViewModel vmCart = Provider.of<CartViewModel>(context);

    return Stack(
      children: [
        // Blue background
        Positioned.fill(
          bottom: 110,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF03AED2), Color(0xFF2196F3)],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        // Name
        const Positioned(
          left: 25,
          top: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hola! Ivan',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                '¿Que se te antoja hoy?',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
            ],
          ),
        ),
        // White background
        Positioned(
          top: 130,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Foody Title
                    Padding(
                      padding: EdgeInsets.only(right: 20, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Address
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                        height: 700,
                                        width: 700,
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Center(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: IconCustomBtn(
                                                  icon: Icon(Icons.add),
                                                  txt: 'Add address',
                                                  onFcn: () {}),
                                            ))
                                          ],
                                        ));
                                  });
                            },
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.location_pin,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text('Condominio Motto'),
                                Icon(Icons.arrow_drop_down_rounded)
                              ],
                            ),
                          ),
                          const Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Foody',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    'App',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.blue),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    // TextFormField
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: DefaultFormField(txt: 'Search', onChanged: (_) {}),
                    ),
                    // ListView categories
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:
                            List.generate(foodWidgetCategories.length, (index) {
                          var category = foodWidgetCategories[index];
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Image.asset(
                                    category['imageUrl'],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  category['title'],
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    // Promotions code
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 180,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children:
                                  List.generate(promotionsList.length, (index) {
                                var category = promotionsList[index];
                                if (category != null &&
                                    category['imageUrl'] != null) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: SizedBox(
                                        height: 280,
                                        width: 340,
                                        child: Image.asset(
                                          category['imageUrl'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                            ),
                          ),
                          const Positioned(
                              top: 30,
                              left: 20,
                              child: Text(
                                'Up to 80%',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          Positioned(
                            left: 20,
                            top: 80,
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'Get Now',
                                  style: TextStyle(color: Colors.black),
                                )),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Nuestro menu',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ShopList(vmHome, vmCart, vm),
                    // Items
                    //HomePostContent(vm, vmCart)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
