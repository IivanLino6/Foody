import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:stripe_payment/data/repository/auth_repository_impl.dart';
import 'package:stripe_payment/data/repository/order_repository_impl.dart';
import 'package:stripe_payment/data/repository/post_repository_impl.dart';
import 'package:stripe_payment/data/repository/user_repository_impl.dart';
import 'package:stripe_payment/domain/repository/orders_repository.dart';
import 'package:stripe_payment/domain/repository/post_repository.dart';
import 'package:stripe_payment/domain/repository/user_repository.dart';
import 'package:stripe_payment/domain/use%20case/auth/reset_passw_usecase.dart';
import 'package:stripe_payment/domain/use%20case/order/order_usescases.dart';
import 'package:stripe_payment/domain/use%20case/order/register_order_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/add_cart_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/create_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/delete_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/get_cart_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/get_post_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/post_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/update_post_image_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/update_usecase.dart';
import 'package:stripe_payment/domain/use%20case/user/getUserById_usecase.dart';
import 'package:stripe_payment/domain/use%20case/user/update_image_usecase.dart';
import 'package:stripe_payment/domain/use%20case/user/update_profile_usecase.dart';
import 'package:stripe_payment/domain/use%20case/user/user_usecase.dart';
import 'package:stripe_payment/services/di/firebase_service.dart';
import 'package:stripe_payment/domain/repository/auth_repository.dart';
import 'package:stripe_payment/domain/use%20case/auth/auth_usecase.dart';
import 'package:stripe_payment/domain/use%20case/auth/login_usecase.dart';
import 'package:stripe_payment/domain/use%20case/auth/logout_usecase.dart';
import 'package:stripe_payment/domain/use%20case/auth/register_usecase.dart';
import 'package:stripe_payment/domain/use%20case/auth/user_session_usecase.dart';
import 'package:stripe_payment/domain/use%20case/stripe/pay_usecase.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart';

//Everytime yo add a new injectable you need execute:
//flutter packages pub run build_runner build
//flutter packages pub run build_runner watch

@module
abstract class AppModule {
  //Services init
  @preResolve //Priority service
  Future<FirebaseService> get firebaseService => FirebaseService.init();
  //----------------------------FIREBASE AUTH------------------------------------------
  //Firebase Auth
  @injectable
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  //--------------------------FIREBASE DATABASE--------------------------------------
  //FirebaseFirestore
  @injectable
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;
  //---------------------------FIREBASE STORAGE-------------------------------------
  //FIrebase Storage Instance
  @injectable
  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;
  //Firebase Storage Users
  @Named('Users')
  @injectable
  Reference get userStorageRef => firebaseStorage.ref().child('Users');
  //Firebase Storage Post
  @Named('Posts')
  @injectable
  Reference get postStorageRef => firebaseStorage.ref().child('Posts');
  //Firebase Storage Post
  @Named('Order')
  @injectable
  Reference get ordersStorageRef => firebaseStorage.ref().child('Orders');

  //-------------------------COLLECTION REFERENCE----------------------------
  @Named('Users')
  @injectable
  CollectionReference get usersCollection =>
      firebaseFirestore.collection("Users");
  @Named('Posts')
  @injectable
  CollectionReference get postsCollection =>
      firebaseFirestore.collection("Posts");
  @Named('Cart')
  @injectable
  CollectionReference get cartCollection =>
      firebaseFirestore.collection("Cart");
  @Named('Orders')
  @injectable
  CollectionReference get ordersCollection =>
      firebaseFirestore.collection("Orders");

  //Auth Repository
  @Environment('Repositories')
  @injectable
  AuthRepository get authRepository =>
      AuthRepositoryImpl(firebaseAuth, usersCollection);

  //User Repository
  @Environment('Repositories')
  @injectable
  UserRepository get userRepository =>
      UserRepositoryImpl(usersCollection, userStorageRef);

  @Environment('Repositories')
  @injectable
  PostRepository get postRepository =>
      PostRepositoryImpl(postsCollection, postStorageRef, cartCollection);

  @Environment('Repositories')
  @injectable
  OrdersRepository get orderRepository => OrderRepositoryImpl(ordersCollection);

  //@Environment('UseCases')
  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
      login: LoginUseCase(authRepository),
      register: RegisterUseCase(authRepository),
      getUser: UserSessionUseCase(authRepository),
      logout: LogoutUseCase(authRepository),
      pay: PayUseCase(authRepository),
      resetPassword: ResetPasswordUseCase(authRepository));

//@Environment('UseCases')
  @injectable
  UserUseCase get userUseCases => UserUseCase(
      getById: GetUserByIdUseCase(userRepository),
      updateWithoutImage: UpdateUserUseCase(userRepository),
      updateWithImage: UpdateImageUseCase(userRepository));
//@Environment('UseCases')
  @injectable
  PostUsesCases get postUsesCases => PostUsesCases(
        create: CreatePostUseCase(postRepository),
        getPost: GetPostUseCase(postRepository),
        delete: DeletePostUseCase(postRepository),
        update: UpdatePostUseCase(postRepository),
        updateWithImage: UpdatePostImageUseCase(postRepository),
        addToCart: AddToCartUseCase(postRepository),
        getCart: GetCartUseCase(postRepository),
      );
  //@Environment('UseCases')
  @injectable
  OrderUsesCases get orderUsesCases =>
      OrderUsesCases(registerOrder: RegisterOrderUseCase(orderRepository));

  @injectable
  CartViewModel get cartViewModel => CartViewModel(postUsesCases, authUseCases);
}
