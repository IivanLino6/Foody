import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/domain/use%20case/user/user_usecase.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:stripe_payment/utils/validation_item.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/update/profile_update_state.dart';

class ProfileUpdateViewModel extends ChangeNotifier {
  UserUseCase _usersUseCase;
  ProfileUpdateState _state = ProfileUpdateState();
  ProfileUpdateState get state => _state;

  Resource _response = Init();
  Resource get response => _response;

  File? _imageFile;
  File? get imageFile => _imageFile;

  ProfileUpdateViewModel(this._usersUseCase);

  changeUsername(String value) {
    if (value.length >= 3) {
      _state =
          _state.copyWith(username: ValidationItem(value: value, error: ''));
    } else {
      _state = _state.copyWith(
          username: ValidationItem(error: 'Al menos 3 caracteres'));
    }
    notifyListeners();
  }

  loadData(UserData userData) {
    print('Argumentos: ${userData.toJson()}');
    _state = _state.copyWith(
        id: ValidationItem(value: userData.id),
        username: ValidationItem(value: userData.username),
        image: ValidationItem(value: userData.image),
        phone: ValidationItem(value: userData.phone));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  update() async {
    if (_state.isValid()) {
      _response = Loading();
      notifyListeners(); // DIALOG ESPERAR
      if (_imageFile == null) {
        _response =
            await _usersUseCase.updateWithoutImage.launch(_state.toUser());
        notifyListeners();
      } else {
        _response = await _usersUseCase.updateWithImage
            .launch(_state.toUser(), _imageFile!);
        notifyListeners();
      }
    }
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

  resetResponse() {
    _response = Init();
    notifyListeners();
  }
}
