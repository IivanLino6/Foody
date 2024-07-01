import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/domain/model/food_categories.dart';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/domain/use%20case/post/post_usecase.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart';

class PostListViewModel extends ChangeNotifier {
  PostUsesCases _postUsesCases; //
  PostListViewModel(this._postUsesCases);

  ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  String _category = '';
  String get category => _category;

  Map<String, double> _categoryPositions = {};
  Map<String, double> get categoryPositions => _categoryPositions;

  Stream<Resource<List<Post>>> getPosts() {
    return _postUsesCases.getPost.launch();
  }
  //Method added to use extension and resize the image
  String concatImage(Post post) {
    // Encuentra la posición del último punto en la cadena
    int indexOfDot = post.image.lastIndexOf('.');

    // Divide la cadena en dos partes: antes y después del punto
    String beforeDot = post.image.substring(0, indexOfDot);
    String afterDot = post.image.substring(indexOfDot);

    // Concatenar el valor antes del punto
    String result = beforeDot + '_200x200' + afterDot;
    return result;
  }

  void deletePost(String idPost) async {
    await _postUsesCases.delete.launch(idPost);
    notifyListeners();
  }

  void addtoCart(Post post, BuildContext context) async {
    //Get data from firebase
    //await _postUsesCases.addToCart.launch(post);
    var vmCart = Provider.of<CartViewModel>(context, listen: false);
    vmCart.addToCart(post);
  }

  //Filter post per cateegory
  Map<String, List<Post>> classifyPostsByCategory(List<Post> posts) {
    Map<String, List<Post>> categorizedPosts = {};
    for (var post in posts) {
      if (categorizedPosts.containsKey(post.category)) {
        categorizedPosts[post.category]!.add(post);
      } else {
        categorizedPosts[post.category] = [post];
      }
    }
    return categorizedPosts;
  }

  void selectCategory(int index) {
    _category = foodWidgetCategories[index]["title"];
    scrollTo(_category);
  }

  void scrollTo(String category) {
    double position = _categoryPositions[category] ?? 0.0;
    print('Desplazamiento a categoría $category en posición $position');
    _scrollController
        .animateTo(
      position,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    )
        .then((_) {
      print('Desplazamiento completado');
    }).catchError((error) {
      print('Error en el desplazamiento: $error');
    });
  }

  void scrollTest() {
    _scrollController.animateTo(740,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void updateCategoryPositions(Map<String, double> positions) {
    _categoryPositions = positions;
  }
}
