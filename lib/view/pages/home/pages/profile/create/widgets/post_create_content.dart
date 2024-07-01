import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stripe_payment/utils/show_actions_camera.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/create/post_create_viewmodel.dart';
import 'package:stripe_payment/widgets/text_field.dart';

class PostCreateContent extends StatelessWidget {
  PostCreateViewModel vm;
  PostCreateContent({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //Add image
          GestureDetector(
              onTap: () {
                //Add image
                showActionsCamera(context, () => vm.pickImage(),
                        () => vm.takePhoto());
              },
              child: Container(
                height: 270,
                child: vm.state.image != null
                    ? Image(
                        image: FileImage(vm.state.image!),
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
              controller: vm.priceController,
                txt: 'Price',
                onChanged: (value) {
                  vm.changePrice(value);
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DefaultFormField(
              controller: vm.descriptionController,
                height: 50,
                txt: 'Description',
                onChanged: (value) {
                  vm.changeDescription(value);
                }),
          ),
          //const Text('Select your category'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color.fromRGBO(238, 238, 238, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: DropdownButton<FoodCategories>(
                    dropdownColor: Colors.white,
                    value: vm.foodCategories,
                    hint: const Text(
                      'Select Category',
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    items: FoodCategories.values.map((category) {
                      return DropdownMenuItem<FoodCategories>(
                        value: category,
                        child: Text(
                          category.toString().split('.').last,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (FoodCategories? newCategory) {
                      vm.setCategorySelect(newCategory!);
                    }),
              ),
            ),
          ),
        
        ],
      ),
    );
  }
}
