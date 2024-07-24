import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/view/pages/home/home_page.dart';
import 'package:stripe_payment/view/pages/navigator_bar/navigator_bottom_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_page.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart';
import 'package:stripe_payment/view/pages/navigator_bar/home_bottom_bar.dart';
import 'package:stripe_payment/view/pages/auth/login/login_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/main/post_list_page.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/main/profile_page.dart';

class NavigatorBottomPage extends StatelessWidget {
  const NavigatorBottomPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginViewModel LoginVm = Provider.of<LoginViewModel>(context);

    NavigatorBottomViewModel vm =
        Provider.of<NavigatorBottomViewModel>(context);
    CartViewModel vmCart = Provider.of<CartViewModel>(context);

    final currentTab = [
      const HomePage(),
      const PostListPage(),
      CartPage(),
      ProfilePage(),
    ];

    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(child: currentTab[vm.currentIndex]),
        Positioned(
            bottom: 0, left: 5, right: 5, child: HomeBottomBar(context, vm,vmCart)),
      ],
    ));
  }
}
