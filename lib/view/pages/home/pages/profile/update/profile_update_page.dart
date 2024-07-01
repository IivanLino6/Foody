import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/view/pages/auth/register/widget/contry_picker_widget.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/update/profile_update_response.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/update/profile_update_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/update/widgets/profile_update_content.dart';
import 'package:stripe_payment/widgets/text_field.dart';

class ProfileUpdatePage extends StatelessWidget {
  const ProfileUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileUpdateViewModel vm = Provider.of<ProfileUpdateViewModel>(context);
    UserData userDataArgs =
        ModalRoute.of(context)?.settings.arguments as UserData;
    
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ProfileUpdateResponse(context, vm);  
    }); // CUANDO TODOS LOS ELEMENTOS YA HAN SIDO MOSTRADOS EN PANATALLAS    

    return ProfileUpdateContent(vm,userDataArgs);
  }
}
