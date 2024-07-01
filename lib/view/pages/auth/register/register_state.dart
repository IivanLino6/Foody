

import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/utils/validation_item.dart';

  class RegisterState {
    ValidationItem email;
    ValidationItem password;
    ValidationItem username;
    ValidationItem validPassword;
    ValidationItem phone;

    //Constructor
    RegisterState(
        {this.email = const ValidationItem(),
        this.password = const ValidationItem(),
        this.username = const ValidationItem(),
        this.validPassword = const ValidationItem(),
        this.phone = const ValidationItem(),
      });

    //Check the values en the error
    bool isValid() {
      if (username.value.isEmpty ||
          username.error.isNotEmpty ||
          email.value.isEmpty ||
          email.error.isNotEmpty ||
          password.value.isEmpty ||
          password.error.isNotEmpty ||
          validPassword.value.isEmpty ||
          validPassword.error.isNotEmpty ||
          phone.value.isEmpty ||
          phone.error.isNotEmpty ||
          (password.value != validPassword.value)) {
        return false;
      }
      return true;
    }
    //Asigna el valor de los campos
    RegisterState copyWith(
            {ValidationItem? email,
            ValidationItem? password,
            ValidationItem? username,
            ValidationItem? validPassword,
            ValidationItem? age,
            ValidationItem? phone,
          }) =>
        RegisterState(
            email: email ?? this.email,
            password: password ?? this.password,
            username: username ?? this.username,
            validPassword: validPassword ?? this.validPassword,
            phone: phone ?? this.phone,);

      toUser() => UserData(
        email: this.email.value,
        username: this.username.value,
        password: this.password.value,
        phone: this.phone.value,
  );
  }
