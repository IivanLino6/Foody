import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/domain/use%20case/post/post_usecase.dart';
import 'package:stripe_payment/domain/use%20case/user/user_usecase.dart';
import 'package:stripe_payment/view/pages/home/home_page.dart';
import 'package:stripe_payment/view/pages/home/home_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/navigator_bottom_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_page.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/chekout/order_page.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/chekout/order_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/main/profile_page.dart';
import 'package:stripe_payment/domain/use%20case/auth/auth_usecase.dart';
import 'package:stripe_payment/services/injection.dart';
import 'package:stripe_payment/view/pages/auth/login/login_page.dart';
import 'package:stripe_payment/view/pages/auth/login/login_viewmodel.dart';
import 'package:stripe_payment/view/pages/auth/register/register_page.dart';
import 'package:stripe_payment/view/pages/auth/register/register_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/navigator_bottom%20page.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/main/post_list_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/main/post_list_page.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/update/post_update_page.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/update/post_update_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/create/post_create_page.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/create/post_create_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/main/profile_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/update/profile_update_page.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/update/profile_update_viewmodel.dart';

import '.env';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  Stripe.publishableKey = StripePubishableKeyTest;
  await Stripe.instance.applySettings();
  runApp(MainApp(locator<AuthUseCases>()));
}

class MainApp extends StatelessWidget {
  AuthUseCases _authUseCases; //
  MainApp(this._authUseCases);

  @override
  Widget build(BuildContext context) {
    String idSession = _authUseCases.getUser.userSession?.uid ?? '';
    print('idSession: ${idSession}');
    return MultiProvider(
      key: Key(idSession),
      providers: [
            ChangeNotifierProvider(
            create: (_) => NavigatorBottomViewModel(locator<AuthUseCases>())),
        ChangeNotifierProvider(
            create: (_) => LoginViewModel(locator<AuthUseCases>())),
        ChangeNotifierProvider(
            create: (_) => RegisterViewModel(locator<AuthUseCases>())),
        ChangeNotifierProvider(
            create: (_) => HomeViewModel(locator<PostUsesCases>())),
        ChangeNotifierProvider(
            create: (_) => ProfileViewModel(
                locator<UserUseCase>(), locator<AuthUseCases>())),
        ChangeNotifierProvider(
            create: (_) => ProfileUpdateViewModel(locator<UserUseCase>())),
        ChangeNotifierProvider(
            create: (_) => PostCreateViewModel(
                locator<AuthUseCases>(), locator<PostUsesCases>())),
        ChangeNotifierProvider(
            create: (_) => PostListViewModel(locator<PostUsesCases>())),
        ChangeNotifierProvider(
            create: (_) => PostUpdateViewModel(
                locator<PostUsesCases>(), locator<AuthUseCases>())),
                ChangeNotifierProvider(
            create: (_) => CartViewModel(
                locator<PostUsesCases>(), locator<AuthUseCases>())),
                ChangeNotifierProvider(
            create: (_) => OrderViewModel( locator<AuthUseCases>(),locator<CartViewModel>()))
      ],
      child: MaterialApp(
        initialRoute: idSession.isEmpty ? 'LoginPage' : 'NavigatorBottomPage',
        routes: {
          'NavigatorBottomPage': (_) => const NavigatorBottomPage(),
          'HomePage': (_) => const HomePage(),
          'LoginPage': (_) => const LoginPage(),
          'RegisterPage': (_) => const RegisterPage(),
          'UpdateProfilePage': (_) => const ProfileUpdatePage(),
          'PostCreatePage': (_) => const PostCreatePage(),
          'PostListPage': (_) => const PostListPage(),
          'PostUpdatePage': (_) => const PostUpdatePage(),
          'CartPage': (_) => CartPage(),
          'ProfilePage': (_) => ProfilePage(),
          'OrderPage': (_) => OrderPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
