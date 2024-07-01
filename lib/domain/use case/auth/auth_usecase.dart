import 'package:stripe_payment/domain/use%20case/auth/login_usecase.dart';
import 'package:stripe_payment/domain/use%20case/auth/logout_usecase.dart';
import 'package:stripe_payment/domain/use%20case/auth/register_usecase.dart';
import 'package:stripe_payment/domain/use%20case/auth/reset_passw_usecase.dart';
import 'package:stripe_payment/domain/use%20case/auth/user_session_usecase.dart';
import 'package:stripe_payment/domain/use%20case/stripe/pay_usecase.dart';

class AuthUseCases {
  LoginUseCase login;
  RegisterUseCase register;
  UserSessionUseCase getUser;
  LogoutUseCase logout;
  PayUseCase pay;
  ResetPasswordUseCase resetPassword;

  //Constructor
  AuthUseCases(
      {required this.login,
      required this.register,
      required this.getUser,
      required this.logout,
      required this.pay,
      required this.resetPassword});
}
