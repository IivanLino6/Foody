import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stripe_payment/domain/use%20case/auth/auth_usecase.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:stripe_payment/utils/validation_item.dart';
import 'package:stripe_payment/view/pages/auth/register/register_state.dart';

class RegisterViewModel extends ChangeNotifier {
  //State
  RegisterState _state = RegisterState();
  RegisterState get state => _state;
  bool _isChecked = false;
  List<bool> _isSelected = [
    false,
    false,
  ];
  //Usecase
  final AuthUseCases _authUseCases;

  RegisterViewModel(this._authUseCases);

  String validPassword = '';

  //Stream Reponse
  StreamController<Resource> _responseController = StreamController<Resource>();
  Stream<Resource> get response => _responseController.stream;
  //Getter
  bool get isCheckboxChecked => _isChecked;
  List<bool> get isSelected => _isSelected;

  // Setter for 'isChecked'
  set isCheckboxChecked(bool value) {
    _isChecked = value;
    notifyListeners(); // Update the variable using setState
  }
  //Setter
  register() async {
    if (_state.isValid()) {
      _responseController.add(Loading());
      final data = await _authUseCases.register
          .launch(_state.toUser()); // SUCCESS - ERROR
      _responseController.add(data);
    } else {
      print('Error en el formulario');
      Fluttertoast.showToast(
          msg:
              'Data no valid\n ${_state.username.error}\n${_state.email.error}\n${_state.phone.error}\n${_state.validPassword.error}\n',
          backgroundColor: Colors.black,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3);
    }
  }

  changeUsername(String value) {
    _state = _state.copyWith(username: ValidationItem(value: value));
    notifyListeners();
  }

  void changeEmail(String value) {
    //Validate email
    final bool validEmail =
        RegExp(r'^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(value);

    if (!validEmail) {
      _state = _state.copyWith(
          email: const ValidationItem(error: 'Is not a valid email'));
    } else if (value.length >= 6) {
      _state = _state.copyWith(email: ValidationItem(value: value, error: ''));
    } else {
      _state =
          _state.copyWith(email: const ValidationItem(error: 'Invalid email'));
    }
    //Notifica al provider del cambio
    notifyListeners();
  }

  changePassword(String value) {
    validPassword = value;
    if (value.length >= 6) {
      _state =
          _state.copyWith(password: ValidationItem(value: value, error: ''));
    } else {
      _state =
          _state.copyWith(password: ValidationItem(error: 'invalid password'));
    }
    notifyListeners();
  }

  changeValidPassword(String value) {
    if (validPassword == value) {
      _state = _state.copyWith(
          validPassword: ValidationItem(value: value, error: ''));
    } else {
      _state = _state.copyWith(
          validPassword: ValidationItem(error: 'Password does not match'));
    }
    notifyListeners();
  }

  changePhone(String value) {
    if (value.length >= 8) {
      _state = _state.copyWith(phone: ValidationItem(value: value, error: ''));
    } else {
      _state =
          _state.copyWith(phone: ValidationItem(error: 'Invalid phone number'));
    }
    notifyListeners();
  }
}
