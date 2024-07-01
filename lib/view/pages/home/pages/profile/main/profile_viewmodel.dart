import 'package:flutter/material.dart';
import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/domain/use%20case/auth/auth_usecase.dart';
import 'package:stripe_payment/domain/use%20case/user/user_usecase.dart';
import 'package:stripe_payment/utils/resources.dart';

class ProfileViewModel extends ChangeNotifier {
  UserUseCase _usersUseCase;
  AuthUseCases _authUseCase;

  ProfileViewModel(this._usersUseCase, this._authUseCase) {
    getuserbyId();
  }

  Stream<Resource<UserData>> getuserbyId() {
    final id = _authUseCase.getUser.userSession?.uid ?? '';
    return _usersUseCase.getById.launch(id: id);
  }

  logout() {
    _authUseCase.logout.launch();
  }
}
