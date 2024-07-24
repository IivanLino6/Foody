import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/create%20restaurant/restaurant_create_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/create%20restaurant/widgets/restaurant_create_content.dart';

class RestaurantCreatePage extends StatelessWidget {
  const RestaurantCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    RestaurantCreateViewModel vm = Provider.of<RestaurantCreateViewModel>(context);
    return Scaffold(
      body: RestaurantCreateContent(vm),
    );
  }
}
