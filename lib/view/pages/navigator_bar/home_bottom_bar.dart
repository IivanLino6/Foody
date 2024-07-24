import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badges/badges.dart' as badges;
import 'package:stripe_payment/view/pages/navigator_bar/navigator_bottom_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart';

class HomeBottomBar extends StatelessWidget {
  NavigatorBottomViewModel vm;
  CartViewModel vmCart;
  BuildContext context;
  HomeBottomBar(this.context, this.vm, this.vmCart, {super.key});

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    int cartItemCount = 1; // Número de ítems en el carrito, puede ser dinámico

    return Container(
      margin: EdgeInsets.all(displayWidth * .05),
      height: displayWidth * .155,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            vm.currentIndex = index;
            HapticFeedback.lightImpact();
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Stack(
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                width: index == vm.currentIndex
                    ? displayWidth * .32
                    : displayWidth * .18,
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: index == vm.currentIndex ? displayWidth * .12 : 0,
                  width: index == vm.currentIndex ? displayWidth * .32 : 0,
                  decoration: BoxDecoration(
                    color: index == vm.currentIndex
                        ? Colors.grey.withOpacity(0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                width: index == vm.currentIndex
                    ? displayWidth * .31
                    : displayWidth * .18,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width:
                              index == vm.currentIndex ? displayWidth * .13 : 0,
                        ),
                        AnimatedOpacity(
                          opacity: index == vm.currentIndex ? 1 : 0,
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: Text(
                            index == vm.currentIndex
                                ? '${listOfStrings[index]}'
                                : '',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == vm.currentIndex
                              ? displayWidth * .03
                              : 20,
                        ),
                        if (index == 2 &&
                            vmCart.itemCounter >
                                0) // Índice 2 es el ícono del carrito
                          badges.Badge(
                            position: badges.BadgePosition.topEnd(),
                            badgeStyle:
                                badges.BadgeStyle(padding: EdgeInsets.all(3)),
                            badgeContent: Text(
                              '${vmCart.itemCounter}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            badgeAnimation: const badges.BadgeAnimation.scale(
                                animationDuration: Duration(milliseconds: 200),
                                colorChangeAnimationDuration:
                                    Duration(seconds: 1),
                                loopAnimation: false,
                                curve: Curves.fastOutSlowIn,
                                colorChangeAnimationCurve: Curves.easeInCubic),
                            child: Icon(
                              listOfIcons[index],
                              size: displayWidth * .05,
                              color: index == vm.currentIndex
                                  ? Colors.black
                                  : Colors.black26,
                            ),
                          )
                        else
                          Icon(
                            listOfIcons[index],
                            size: displayWidth * .05,
                            color: index == vm.currentIndex
                                ? Colors.black
                                : Colors.black26,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<IconData> listOfIcons = [
  Icons.home_rounded,
  Icons.shop,
  Icons.shopping_cart_rounded,
  Icons.person_rounded,
];

List<String> listOfStrings = [
  'Home',
  'Menu',
  'Cart',
  'Account',
];
