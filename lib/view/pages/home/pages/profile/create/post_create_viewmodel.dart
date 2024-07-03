import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stripe_payment/domain/use%20case/auth/auth_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/post_usecase.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:stripe_payment/utils/validation_item.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/create/post_create_state.dart';

enum FoodCategories {
  salads,
  smothies,
  desserts,
  sandwiches,
  bowls,
  drinks;
}

class PostCreateViewModel extends ChangeNotifier {
  FoodCategories? _foodCategories;
  FoodCategories? get foodCategories => _foodCategories;

  PostsCreateState _state = PostsCreateState();
  PostsCreateState get state => _state;

  File? _imageFile;
  File? get imageFile => _imageFile;

  Resource _response = Init();
  Resource get response => _response;
  
  AuthUseCases _authUseCases;
  PostUsesCases _postUsesCases;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  PostCreateViewModel(this._authUseCases, this._postUsesCases) {
    _state =
        _state.copyWith(idUser: _authUseCases.getUser.userSession?.uid ?? '');
  }
  void setCategorySelect(FoodCategories foodCategories) {
    _foodCategories = foodCategories;
    switch (foodCategories) {
      case FoodCategories.salads:
        _state = _state.copyWith(category: 'Salads');
        break;
      case FoodCategories.smothies:
        _state = _state.copyWith(category: 'Smoothies');
        break;
      case FoodCategories.desserts:
        _state = _state.copyWith(category: 'Desserts');
        break;
      case FoodCategories.sandwiches:
        _state = _state.copyWith(category: 'Sandwiches');
        break;
      case FoodCategories.bowls:
        _state = _state.copyWith(category: 'Bowls');
        break;
      case FoodCategories.drinks:
        _state = _state.copyWith(category: 'Drinks');
        break;
    }
    notifyListeners();
    print(foodCategories.toString());
  }

  changeName(String value) {
    _state = _state.copyWith(name: ValidationItem(value: value, error: ''));
    notifyListeners();
  }

  changePrice(String value) {
    double? doubleValue = double.tryParse(value);
    if (doubleValue != null) {
      _state = _state.copyWith(price: ValidationItem(value: value, error: ''));
    } else {
      _state = _state.copyWith(
          price: const ValidationItem(error: 'Is not a number'));
    }
    notifyListeners();
  }

  changeDescription(String value) {
    _state = _state.copyWith(description: ValidationItem(value: value));
    notifyListeners();
  }

  //Image picker
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageFile = File(image.path);
      print(image.path);
      _state = _state.copyWith(image: _imageFile);
      notifyListeners();
    }
  }

  Future<void> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _imageFile = File(image.path);
      _state = _state.copyWith(image: _imageFile);
      notifyListeners();
    }
  }

  createPost() async {
    _state =
        _state.copyWith(idUser: _authUseCases.getUser.userSession?.uid ?? '');
    if (_state.isValid()) {
      _response = Loading();
      notifyListeners();
      _response =
          await _postUsesCases.create.launch(_state.toPost(), _state.image!);
      notifyListeners();
    } else {
      _state = _state.copyWith(error: 'Debes completar todos los campos');
      print('FORMULARIO NO VALIDO');
      notifyListeners();
    }
  }

  resetResponse() {
    _response = Init();
    notifyListeners();
  }

  resetState() {
    _state = PostsCreateState();
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    notifyListeners();
  }
}
