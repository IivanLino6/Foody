import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stripe_payment/domain/use%20case/auth/auth_usecase.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:stripe_payment/utils/validation_item.dart';
import 'package:stripe_payment/view/pages/auth/login/login_state.dart';

//Mediante el provider permite mandar los datos a la vista
class LoginViewModel extends ChangeNotifier {
  //States
  LoginState _state = LoginState();
  LoginState get state => _state;

  StreamController<Resource> _responseController = StreamController<Resource>();
  Stream<Resource> get response => _responseController.stream;

  //UseCases
  AuthUseCases _authUseCases;

  //Contructor
  LoginViewModel(this._authUseCases);
  //Setter
  void changeEmail(String value) {
    if (value.length >= 3) {
      _state = _state.copyWith(email: ValidationItem(value: value));
    } else {
      _state = _state.copyWith(
          email: const ValidationItem(error: 'Al menos 3 caaracteres'));
    }
    //Notifica al provider del cambio
    notifyListeners();
  }

  void changePassword(String value) {
    if (value.length >= 6) {
      _state = _state.copyWith(password: ValidationItem(value: value));
    } else {
      _state = _state.copyWith(
          password: const ValidationItem(error: 'Al menos 6 caracteres'));
    }
    //Notifica al provider del cambio
    notifyListeners();
  }

  void login() async {
    if (state.isValid()) {   
      _responseController.add(Loading());       
      final data  = await _authUseCases.login.launch(
        email: _state.email.value,
        password: _state.password.value
      ); // SUCCESS - ERROR
      _responseController.add(data);                 
    } else {
      Fluttertoast.showToast(
          fontSize: 14,
          msg: 'User not valid',
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.black,
          timeInSecForIosWeb: 3);
    }
  }

  //Logout
  logout() async {
    await _authUseCases.logout.launch();
    notifyListeners();
  }

  //Reset Password
  void resetEmail() async {
    if (_state.email.value != '') {
      await _authUseCases.resetPassword.launch(email: _state.email.value);
    } else {
      Fluttertoast.showToast(
          fontSize: 14,
          msg: 'Email not valid',
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.black,
          timeInSecForIosWeb: 3);
    }
    //Notifica al provider del cambio
    notifyListeners();
  }

  //Resetea la variable reponse despues del error
}
