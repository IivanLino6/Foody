

import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/domain/repository/auth_repository.dart';

class RegisterUseCase {
  AuthRepository _repository;

  //Contructor
  RegisterUseCase(this._repository);

  //Method
  launch(UserData user) => _repository.register(user);
}