import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/domain/use%20case/auth/auth_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/post_usecase.dart';
import 'package:stripe_payment/domain/use%20case/user/user_usecase.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:stripe_payment/utils/validation_item.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/update/posts_update_state.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/create/post_create_viewmodel.dart';

class PostUpdateViewModel extends ChangeNotifier {
  FoodCategories? _foodCategories;
  FoodCategories? get foodCategories => _foodCategories;

  PostsUpdateState _state = PostsUpdateState();
  PostsUpdateState get state => _state;

  File? _imageFile;
  File? get imageFile => _imageFile;

  Resource _response = Init();
  Resource get response => _response;

  PostUsesCases _postUsesCases;
  AuthUseCases _authUseCases;

  PostUpdateViewModel(this._postUsesCases, this._authUseCases) {
    _state =
        _state.copyWith(idUser: _authUseCases.getUser.userSession?.uid ?? '');
  }

  Future<void> loadData(Post post) async {
    if (_state.id.isEmpty) {
      _state = _state.copyWith(
          id: post.id,
          name: ValidationItem(value: post.name),
          description: ValidationItem(value: post.description),
          price: ValidationItem(value: post.price),
          image: post.image,
          idUser: post.idUser,
          category: post.category);
    }
  }

  void setCategorySelect(FoodCategories foodCategories) {
    _foodCategories = foodCategories;
    switch (foodCategories) {
      case FoodCategories.salads:
        _state = _state.copyWith(category: 'salads');
        break;
      case FoodCategories.smothies:
        _state = _state.copyWith(category: 'Smothies');
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
      notifyListeners();
    }
  }

  Future<void> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _imageFile = File(image.path);
      notifyListeners();
    }
  }

  updatePost() async {
    _state =
        _state.copyWith(idUser: _authUseCases.getUser.userSession?.uid ?? '');
    if (_state.isValid()) {
      _response = Loading();
      notifyListeners();
      if (_imageFile == null) { // SIN IMAGEN
        _response = await _postUsesCases.update.launch(_state.toPost());
      }
      else {
        _response = await _postUsesCases.updateWithImage.launch(_state.toPost(), _imageFile!);
      }      
      notifyListeners();
    }
    else {
      _state = _state.copyWith(error: 'Debes completar todos los campos');
      notifyListeners();
    }
  }

  resetResponse() {
    _response = Init();
    notifyListeners();
  }
}
