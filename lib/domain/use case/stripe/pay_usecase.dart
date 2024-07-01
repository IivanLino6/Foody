import 'package:flutter/widgets.dart';
import 'package:stripe_payment/domain/repository/auth_repository.dart';
import 'package:stripe_payment/domain/use%20case/auth/auth_usecase.dart';

class PayUseCase {
  AuthRepository _authRepository;
  PayUseCase(this._authRepository);

  launch(
          {required String email,
          required double amount,
          required BuildContext context,
          required}) =>
      _authRepository.pay(email: email, amount: amount, context: context);
}
