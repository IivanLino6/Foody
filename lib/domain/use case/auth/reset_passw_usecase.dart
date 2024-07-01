import 'package:stripe_payment/domain/repository/auth_repository.dart';

class ResetPasswordUseCase {
  AuthRepository _authRepository;

  ResetPasswordUseCase(this._authRepository);

  launch({required String email}) =>
      _authRepository.resetPassword(email: email);
}
