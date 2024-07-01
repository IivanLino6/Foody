import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:stripe_payment/view/pages/auth/register/register_viewmodel.dart';
import 'package:stripe_payment/view/pages/auth/register/widget/contry_picker_widget.dart';
import 'package:stripe_payment/widgets/custom_btn.dart';
import 'package:stripe_payment/widgets/text_field.dart';

class RegisterContent extends StatelessWidget {
  RegisterViewModel vm;

  RegisterContent(this.vm);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sign Up',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            //Blue Background
            Positioned.fill(
              child: Container(
                color: Colors.white,
              ),
            ),
            
            //White background
            Positioned(
                top: screenHeight * .20,
                child: Container(
                  height: screenHeight,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35)),
                      color: Colors.white60),
                  child: Column(
                    children: [
                      //Title
                      //Name field
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: 320,
                                child: DefaultFormField(
                                    txt: 'Name',
                                    onChanged: (value) {
                                      vm.changeUsername(value);
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Email field
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.email),
                            ),
                            SizedBox(
                              width: 330,
                              child: DefaultFormField(
                                  txt: 'Email',
                                  onChanged: (value) {
                                    vm.changeEmail(value);
                                  }),
                            ),
                          ],
                        ),
                      ),
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
                                  txt: 'Phone Number',
                                  txtType: TextInputType.phone,
                                  onChanged: (value) {
                                    vm.changePhone(value);
                                  }),
                            ),
                          ],
                        ),
                      ),
                      //Password
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.lock),
                            ),
                            SizedBox(
                              width: 330,
                              child: DefaultFormField(
                                  hideTxt: true,
                                  txt: 'Password',
                                  onChanged: (value) {
                                    vm.changePassword(value);
                                  }),
                            ),
                          ],
                        ),
                      ),
                      //Verify password
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.lock),
                            ),
                            SizedBox(
                              width: 330,
                              child: DefaultFormField(
                                  hideTxt: true,
                                  txt: 'Confirm passsword',
                                  onChanged: (value) {
                                    vm.changeValidPassword(value);
                                  }),
                            ),
                          ],
                        ),
                      ),
                      // //Select Gender
                      // Row(
                      //   children: [
                      //     Text('Select Gender'),
                      //     ToggleButtons(
                      //       selectedColor: Colors.blue,
                      //       color: Colors.blueGrey,
                      //       isSelected: vm.isSelected,
                      //       borderRadius: BorderRadius.circular(15),
                      //       children: const [
                      //         SizedBox(
                      //           width: 45,
                      //         child: Icon(Icons.man,color: Colors.black,)), 
                      //         Icon(Icons.woman, color: Colors.black,)],
                      //       onPressed: (int index) {
                      //         vm.genderSelect(index);
                      //       },
                      //     ),
                      //   ],
                      // ),
                      //Checkbox
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                  activeColor: Colors.blue,
                                  value: vm.isCheckboxChecked,
                                  onChanged: (newBool) {
                                    vm.isCheckboxChecked = newBool!;
                                  }),
                              const Text('Accept license and agreement')
                            ]),
                      ),
                      //Sign up btn
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                            width: 150,
                            height: 50,
                            child: CustomBtn(
                                txt: 'Sign Up',
                                color: Colors.black,
                                onFcn: () {
                                  vm.register();
                                })),
                      )
                    ],
                  ),
                )),
            //Animation
            Positioned(
              top: 1,
              child: Center(
                child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Lottie.asset('asset/Lottie/user.json')),
              ),
            ),
          ],
        ));
  }
}
