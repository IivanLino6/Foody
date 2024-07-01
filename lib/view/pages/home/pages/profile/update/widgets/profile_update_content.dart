import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/utils/show_actions_camera.dart';
import 'package:stripe_payment/view/pages/auth/register/widget/contry_picker_widget.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/update/profile_update_viewmodel.dart';
import 'package:stripe_payment/widgets/text_field.dart';

class ProfileUpdateContent extends StatefulWidget {
  ProfileUpdateViewModel vm;
  UserData userDataArgs;
  ProfileUpdateContent(this.vm, this.userDataArgs);

  @override
  State<ProfileUpdateContent> createState() => _ProfileUpdateContentState();
}

class _ProfileUpdateContentState extends State<ProfileUpdateContent> {
//This method let you run the functiion loadData only once that's why we are using a StatefulWidget
  @override
  void initState() {
    widget.vm.loadData(widget.userDataArgs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Profile'),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  showActionsCamera(context, () => widget.vm.pickImage(),
                      () => widget.vm.takePhoto());
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: widget.vm.imageFile != null 
                    ? FileImage(widget.vm.imageFile!)
                    : widget.userDataArgs.image.isNotEmpty 
                      ? NetworkImage(widget.userDataArgs.image)
                      : AssetImage('assets/img/user_image.png') as ImageProvider,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  widget.vm.pickImage();
                },
                child: const Text(
                  'Change profile picture',
                  style: TextStyle(fontSize: 8),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Icon(Icons.person),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 320,
                      child: DefaultFormField(
                          initialValue: widget.vm.state.username.value,
                          txt: 'Name',
                          onChanged: (value) {
                            //vm.changeUsername(value);
                            widget.vm.changeUsername(value);
                          }),
                    ),
                  ),
                ],
              ),
            ),
            // field
            //Phone Number field
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: CountryPickerWidget(),
                  ),
                  SizedBox(
                    width: 260,
                    child: DefaultFormField(
                        initialValue: widget.vm.state.phone.value,
                        txt: 'Phone Number',
                        txtType: TextInputType.phone,
                        onChanged: (value) {
                          //vm.changePhone(value);
                        }),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: ElevatedButton(
                onPressed: () {
                  widget.vm.update();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black, // Set text color to white
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12.0), // Set rounded corners
                  ),
                  elevation: 10.0, // Adjust elevation as desired
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0), // Customize padding
                ),
                child: const Text('Edit Profile'), // Set button text
              ),
            )
          ],
        ));
  }
}
