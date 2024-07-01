//This class will validate the data write on the text fiel
import 'package:stripe_payment/utils/validation_item.dart';

class LoginState {
  ValidationItem email;
  ValidationItem password;

  //Contructor
  LoginState(
      {this.email = const ValidationItem(),
      this.password = const ValidationItem()});

  //Method
  
  //Asigna el valor de email y password
  LoginState copyWith({ValidationItem? email, ValidationItem? password}) =>
      LoginState(
          email: email ?? this.email, 
          password: password ?? this.password);

  bool isValid() {
    if (email.value.isEmpty|| 
        email.error.isNotEmpty||
        password.value.isEmpty|| 
        password.error.isNotEmpty
    ) {
      return false;
    } else {
      return true;
    }
  }
}