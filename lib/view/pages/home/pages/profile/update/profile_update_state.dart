import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/utils/validation_item.dart';

class ProfileUpdateState {

  ValidationItem id;
  ValidationItem username;
  ValidationItem image;
  ValidationItem phone;

  ProfileUpdateState({
    this.id = const ValidationItem(),
    this.username = const ValidationItem(),
    this.image = const ValidationItem(), 
    this.phone = const ValidationItem()
  });

  toUser() => UserData(
    id: this.id.value,
    username: this.username.value,
    image: this.image.value,
    phone: this.phone.value,
  );

  ProfileUpdateState copyWith({
    ValidationItem? id,
    ValidationItem? username,
    ValidationItem? image,
    ValidationItem? phone
  }) => ProfileUpdateState(
    id: id ?? this.id,
    username: username ?? this.username,
    image: image ?? this.image,
    phone: phone ?? this.phone,
  );

  bool isValid() {
    if (
      id.value.isEmpty ||
      id.error.isNotEmpty ||
      username.value.isEmpty ||
      username.error.isNotEmpty||
      phone.error.isNotEmpty||
      phone.value.isEmpty
    ) {
      return false;
    }
    return true;    
  }

}