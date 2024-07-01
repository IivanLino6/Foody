import 'package:stripe_payment/domain/repository/auth_repository.dart';

class LogoutUseCase {
  AuthRepository _repository;
  //Contructor
  LogoutUseCase(this._repository);

  launch() => _repository.logout();
}