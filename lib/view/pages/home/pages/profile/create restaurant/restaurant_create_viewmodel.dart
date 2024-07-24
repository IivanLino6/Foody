import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/utils/validation_item.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/create%20post/post_create_state.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/create%20restaurant/restaurant_create_state.dart';

class RestaurantCreateViewModel extends ChangeNotifier {
  RestaurantCreateState _state = RestaurantCreateState();
  RestaurantCreateState get state => _state;

  //State for add items
  PostsCreateState _postState = PostsCreateState();
  PostsCreateState get postState => _postState;

  File? _imageFile;
  File? get imageFile => _imageFile;

  //Textfield controller
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController itemsController = TextEditingController();

  //Post List
  List<Post> _postList = [];
  List<Post> get postList => _postList;

  changeName(String value) {
    _state = _state.copyWith(name: value);
  }

  changeAddress(String value) {
    _state = _state.copyWith(address: value);
  }

  changeItemName(String value) {
    _postState = _postState.copyWith(name: ValidationItem(value: value));
  }
  changeItemPrice(String value) {
    _postState = _postState.copyWith(price:ValidationItem(value: value));
  }
  changeItemDescription(String value) {
    _postState = _postState.copyWith(description: ValidationItem(value: value));
  }
  //Image picker
  Future<void> pickItemImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageFile = File(image.path);
      _state = _state.copyWith(logoUrl: _imageFile);
      notifyListeners();
    }
  }

  Future<void> takeItemPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _imageFile = File(image.path);
      _state = _state.copyWith(logoUrl: _imageFile);
      notifyListeners();
    }
  }
  
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageFile = File(image.path);
      _state = _state.copyWith(logoUrl: _imageFile);
      notifyListeners();
    }
  }

  Future<void> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _imageFile = File(image.path);
      _state = _state.copyWith(logoUrl: _imageFile);
      notifyListeners();
    }
  }

  void addItem(Post post) {
    _postList.add(post);
    notifyListeners();
  }
}
