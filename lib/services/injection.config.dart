// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_storage/firebase_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stripe_payment/domain/repository/auth_repository.dart' as _i11;
import 'package:stripe_payment/domain/repository/post_repository.dart' as _i13;
import 'package:stripe_payment/domain/repository/user_repository.dart' as _i12;
import 'package:stripe_payment/domain/use%20case/auth/auth_usecase.dart' as _i7;
import 'package:stripe_payment/domain/use%20case/post/post_usecase.dart' as _i9;
import 'package:stripe_payment/domain/use%20case/post/update_post_image_usecase.dart'
    as _i14;
import 'package:stripe_payment/domain/use%20case/user/user_usecase.dart' as _i8;
import 'package:stripe_payment/services/di/app_module.dart' as _i15;
import 'package:stripe_payment/services/di/firebase_service.dart' as _i3;
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart'
    as _i10;

const String _Repositories = 'Repositories';

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i3.FirebaseService>(
      () => appModule.firebaseService,
      preResolve: true,
    );
    gh.factory<_i4.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.factory<_i5.FirebaseFirestore>(() => appModule.firebaseFirestore);
    gh.factory<_i6.FirebaseStorage>(() => appModule.firebaseStorage);
    gh.factory<_i7.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i8.UserUseCase>(() => appModule.userUseCases);
    gh.factory<_i9.PostUsesCases>(() => appModule.postUsesCases);
    gh.factory<_i10.CartViewModel>(() => appModule.cartViewModel);
    gh.factory<_i6.Reference>(
      () => appModule.postStorageRef,
      instanceName: 'Posts',
    );
    gh.factory<_i5.CollectionReference<Object?>>(
      () => appModule.postsCollection,
      instanceName: 'Posts',
    );
    gh.factory<_i6.Reference>(
      () => appModule.userStorageRef,
      instanceName: 'Users',
    );
    gh.factory<_i5.CollectionReference<Object?>>(
      () => appModule.usersCollection,
      instanceName: 'Users',
    );
    gh.factory<_i5.CollectionReference<Object?>>(
      () => appModule.cartCollection,
      instanceName: 'Cart',
    );
    gh.factory<_i11.AuthRepository>(
      () => appModule.authRepository,
      registerFor: {_Repositories},
    );
    gh.factory<_i12.UserRepository>(
      () => appModule.userRepository,
      registerFor: {_Repositories},
    );
    gh.factory<_i13.PostRepository>(
      () => appModule.postRepository,
      registerFor: {_Repositories},
    );
    gh.factory<_i14.UpdatePostImageUseCase>(
        () => _i14.UpdatePostImageUseCase(gh<_i13.PostRepository>()));
    return this;
  }
}

class _$AppModule extends _i15.AppModule {}
