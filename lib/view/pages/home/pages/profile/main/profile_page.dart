import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:stripe_payment/view/pages/home/navigator_bottom_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/main/profile_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/main/widgets/profile_content.dart';
import 'package:stripe_payment/widgets/custom_btn.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileViewModel vm = Provider.of<ProfileViewModel>(context);
    return Scaffold(
        body: StreamBuilder(
            stream: vm.getuserbyId(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final response = snapshot.data;
              if (response is Error) {
                final data = response as Error;
                return Center(
                  child: Text(
                      'Error ${data.error}'),
                );
              }
              final success = response as Success<UserData>;
              return ProfileContent( success.data,vm);
            })));
  }
}
