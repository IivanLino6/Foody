import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/domain/use%20case/auth/auth_usecase.dart';
import 'package:stripe_payment/main.dart';
import 'package:stripe_payment/services/injection.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:stripe_payment/view/pages/auth/login/login_viewmodel.dart';
import 'package:stripe_payment/view/pages/auth/register/register_viewmodel.dart';
import 'package:stripe_payment/view/pages/auth/register/widget/register_content.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterViewModel vm = Provider.of<RegisterViewModel>(context);
    LoginViewModel vmLogin = Provider.of<LoginViewModel>(context);

    return Stack(
      children: [
        StreamBuilder(
            stream: vm.response,
            builder: (context, snapshot) {
              final response = snapshot.data;
              if (response is Loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (response is Error) {
                final data = response as Error;
                Fluttertoast.showToast(
                    msg: 'Error: ${data.error}',
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 3);
              } else if (response is Success) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainApp(locator<AuthUseCases>()),
                      ),
                      (route) => false);
                });
              }
              return Container();
            }),
        RegisterContent(vm)
      ],
    );
  }
}
