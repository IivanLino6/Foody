import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/domain/use%20case/auth/auth_usecase.dart';
import 'package:stripe_payment/main.dart';
import 'package:stripe_payment/services/injection.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/main/profile_viewmodel.dart';
import 'package:stripe_payment/widgets/icon_button.dart';

class ProfileContent extends StatelessWidget {
  UserData userData;
  ProfileViewModel vm;

  ProfileContent(
    this.userData,
    this.vm
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 80,
        ),
        //Title
        Title(
            color: Colors.grey,
            child: const Text('Profile',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold))),
        const SizedBox(
          height: 10,
        ),
        //Profile info
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Container(
            width: 370,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(25.0), // Set radius for rounded corners
              color: Colors.white, // Set background color
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1), // Shadow color
                  offset: Offset(0, 3), // Shadow offset
                  blurRadius: 5.0, // Shadow blur radius
                  spreadRadius: 2.0, // Shadow spread radius
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Avatar
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        maxRadius: 40,
                        backgroundImage: userData.image.isNotEmpty
                            ? NetworkImage(userData.image)
                            : const AssetImage('asset/profile.png')
                                as ImageProvider,
                        //foregroundImage: AssetImage('asset/apple.png'),
                      ),
                    ],
                  ),
                  //Name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Hi! ${userData.username}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'UserID: ${userData.id}',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 45, top: 15),
                        child: SizedBox(
                          height: 25,
                          width: 150,
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle button press action
                                Navigator.pushNamed(
                                    context, 'UpdateProfilePage',
                                    arguments: userData);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.white), // Set white background
                                elevation: MaterialStateProperty.all(
                                    1), // Set elevation for 3D effect
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5), // Set rounded corners for square shape
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        //line
        const SizedBox(
          height: 15,
        ),
        //Address, payment and recepits
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Adress
              GestureDetector(
                onTap: () {
                  print('Press btn');
                },
                child: Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Set radius for rounded corners
                      color: Colors.white, // Set background color
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1), // Shadow color
                          offset: Offset(0, 3), // Shadow offset
                          blurRadius: 5.0, // Shadow blur radius
                          spreadRadius: 2.0, // Shadow spread radius
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Image.asset(
                            'asset/home.png',
                            height: 45,
                            width: 30,
                          ),
                        ),
                        Text('Address')
                      ],
                    )),
              ),
              //Bussisness Info
              GestureDetector(
                onTap: () {},
                child: Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Set radius for rounded corners
                      color: Colors.white, // Set background color
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1), // Shadow color
                          offset: Offset(0, 3), // Shadow offset
                          blurRadius: 5.0, // Shadow blur radius
                          spreadRadius: 2.0, // Shadow spread radius
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Image.asset(
                            'asset/bill.png',
                            height: 45,
                            width: 30,
                          ),
                        ),
                        Text('Info')
                      ],
                    )),
              ),
              //Recepits
              GestureDetector(
                onTap: () {},
                child: Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Set radius for rounded corners
                      color: Colors.white, // Set background color
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1), // Shadow color
                          offset: Offset(0, 3), // Shadow offset
                          blurRadius: 5.0, // Shadow blur radius
                          spreadRadius: 2.0, // Shadow spread radius
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Image.asset(
                            'asset/credit-card.png',
                            height: 45,
                            width: 30,
                          ),
                        ),
                        Text('Recepits')
                      ],
                    )),
              ),
              //Add product
            ],
          ),
        ),
        //line
        const SizedBox(
          height: 15,
        ),
        //General
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Container(
            
            width: 370,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(25.0), // Set radius for rounded corners
              color: Colors.white, // Set background color
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1), // Shadow color
                  offset: Offset(0, 3), // Shadow offset
                  blurRadius: 5.0, // Shadow blur radius
                  spreadRadius: 2.0, // Shadow spread radius
                ),
              ],
            ),
            child: Column(
              children: [
                //General title
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Title(
                      color: Colors.grey,
                      child: const Text('General',
                          style: TextStyle(color: Colors.grey, fontSize: 18))),
                ),
                //View Orders
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      //color: Colors.amber,
                      height: 50,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.receipt, color: Colors.grey),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('View Orders',
                                  style: TextStyle(fontSize: 16)),
                              Text(
                                'Check your recepits and orders',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //Terms of use
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      //color: Colors.amber,
                      height: 50,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.format_align_center,
                                color: Colors.grey),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Terms of use',
                                  style: TextStyle(fontSize: 16)),
                              Text(
                                'Check all terms info',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //Security
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                
                    },
                    child: Container(
                      //color: Colors.amber,
                      height: 50,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.security, color: Colors.grey),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Security', style: TextStyle(fontSize: 16)),
                              Text(
                                'Check your recepits and orders',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //Add new product
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'PostCreatePage');
                    },
                    child: Container(
                      //color: Colors.amber,
                      height: 50,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.add_outlined, color: Colors.grey),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Add Product',
                                  style: TextStyle(fontSize: 16)),
                              Text(
                                'Register a new product',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'RestaurantCreatePage');
                    },
                    child: Container(
                      //color: Colors.amber,
                      height: 50,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.add_outlined, color: Colors.grey),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Add Restaurant',
                                  style: TextStyle(fontSize: 16)),
                              Text(
                                'Register a new Restaurant',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //Space
        SizedBox(
          height: 5,
        ),
         IconCustomBtn(
            icon: Icon(Icons.logout),
            txt: 'Logout',
            onFcn: () {
              vm.logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainApp(locator<AuthUseCases>()),
                  ),
                  (route) => false);
            })
        //Logout Btn
       
      ],
    );
  }
}
