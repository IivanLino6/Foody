import 'package:flutter/material.dart';
import 'package:stripe_payment/view/pages/auth/login/login_viewmodel.dart';
import 'package:stripe_payment/widgets/custom_btn.dart';
import 'package:stripe_payment/widgets/text_field.dart';

class LoginContent extends StatelessWidget {
  LoginViewModel vm;
  LoginContent(this.vm, {super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
                bottom: 200,
                child: Image.asset(
                  'asset/food.jpg',
                  fit: BoxFit.cover,
                )),
            //Welcome title
            const Positioned(
                top: 150,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            //2nd Title
            const Positioned(
                top: 200,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'To Foddy',
                    style: TextStyle(
                        color: Color.fromARGB(255, 3, 162, 248),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            //White Background
            Container(
              width: double.infinity,
              margin:
                  const EdgeInsets.only(top: 380), // Ajusta según tus necesidades
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45)) // Esquinas redondeadas
                  ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child:
                        //Sign In title
                        Text(
                      'Sign In',
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //Email field
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
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
                  //Password field
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
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
                  //Forgot password?
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        //Forgot password
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 200,
                                width: screenWidth,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        'Write your email to reset your password'),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: DefaultFormField(
                                          txt: 'Email',
                                          onChanged: (value) {
                                            vm.changeEmail(value);
                                          }),
                                    ),
                                    CustomBtn(
                                        onFcn: () {
                                          vm.resetEmail();
                                          Navigator.pop(context);
                                        },
                                        txt: 'Send')
                                  ],
                                ),
                              );
                            });
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[500],
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.grey[500]),
                      ),
                    ),
                  ),
                  //Sign in button
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: 50,
                      width: 140,
                      child: CustomBtn(
                          txt: 'Sign In',
                          onFcn: () {
                            vm.login();
                          }),
                    ),
                  ),
                  //Create an account text
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'RegisterPage');
                      },
                      child: Text(
                        'Create an account',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[500],
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.grey[500]),
                      ),
                    ),
                  ),
                  //Singup Text
                  const Text(
                    'Sign In with:',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  //SingUp Buttons
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Esquinas redondeadas
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'asset/google.png',
                                    fit: BoxFit.cover,
                                    width: 22,
                                    height: 22,
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor: Colors.black,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Esquinas redondeadas
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'asset/apple.png',
                                    fit: BoxFit.cover,
                                    width: 22,
                                    height: 22,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Powered by:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Powered By Firebase',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[350])),
                      SizedBox(
                          height: 15, child: Image.asset('asset/firebase.png'))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
