import 'package:flutter/material.dart';
import 'package:stripe_payment/utils/show_actions_camera.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/create%20restaurant/restaurant_create_viewmodel.dart';
import 'package:stripe_payment/widgets/custom_btn.dart';
import 'package:stripe_payment/widgets/icon_button.dart';
import 'package:stripe_payment/widgets/text_field.dart';

class RestaurantCreateContent extends StatelessWidget {
  RestaurantCreateViewModel vm;
  RestaurantCreateContent(this.vm);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //Add image
          GestureDetector(
              onTap: () {
                //Add image
                showActionsCamera(
                    context, () => vm.pickImage(), () => vm.takePhoto());
              },
              
              child: Container(
                height: 270,
                child: vm.state.logoUrl != null
                    ? Image(
                        image: FileImage(vm.state.logoUrl!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.35,
                      ) // Use Image for selected file
                    : Stack(
                        children: [
                          // Placeholder image
                          Positioned(
                            top: 90,
                            right: 140,
                            child: Column(
                              children: [
                                Center(
                                  child: Image.asset('asset/gallery.png',
                                      scale: 6, fit: BoxFit.cover),
                                ),
                                // Text overlay
                                const Center(
                                  child: Text(
                                    'Add an image',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
              )),
          // Fields
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DefaultFormField(
                controller: vm.nameController,
                txt: 'Name',
                onChanged: (value) {
                  vm.changeName(value);
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DefaultFormField(
                controller: vm.addressController,
                txt: 'Address',
                onChanged: (value) {
                  vm.changeAddress(value);
                }),
          ),
          Text('Items List'),
          Container(height: 280,),
           IconCustomBtn(icon: Icon(Icons.add), txt: 'Add items', onFcn: (){showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: 1300,
                                    width: 700,
                                    child: Column(
                                      children: [
                                        GestureDetector(
              onTap: () {
                //Add image
                showActionsCamera(
                    context, () => vm.pickImage(), () => vm.takePhoto());
              },
              
              child: Container(
                
                height: 130,
                child: vm.state.logoUrl != null
                    ? Image(
                        image: FileImage(vm.state.logoUrl!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.50,
                      ) // Use Image for selected file
                    : Stack(
                        children: [
                          // Placeholder image
                          Positioned(
                            top: 30,
                            right: 140,
                            child: Column(
                              children: [
                                Center(
                                  child: Image.asset('asset/gallery.png',
                                      scale: 10, fit: BoxFit.cover),
                                ),
                                // Text overlay
                                const Center(
                                  child: Text(
                                    'Add an image',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
              )),
                                        Spacer(),
                                        Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(30.0),
                                          child: IconCustomBtn(
                                              icon: Icon(Icons.add),
                                              txt: 'Add ',
                                              onFcn: () {}),
                                        ))
                                      ],
                                    ));
                              });}),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: IconCustomBtn(color: Colors.green,txtColor: Colors.white,icon: Icon(Icons.done), txt: 'Complete', onFcn: (){}),
           )
          //const Text('Select your category')
        ],
      ),
    );
  }
}
