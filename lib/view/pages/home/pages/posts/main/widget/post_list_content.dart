import 'package:flutter/material.dart';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/main/post_list_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/main/widget/post_list_item.dart';

class PostListContent extends StatefulWidget {
  PostListViewModel vm;
  CartViewModel vmCart;
  PostListContent(this.vm,this.vmCart, {super.key});

  @override
  State<PostListContent> createState() => _PostListContentState();
}

class _PostListContentState extends State<PostListContent> {
  final Map<String, double> _categoryPositions = {};

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.vm.getPosts(),
        builder: ((context, snapshot) {
          final response = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No Info',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          if (response is Error) {
            final data = response as Error;
            return Center(
              child: Text('Error: ${data.error}'),
            );
          }
          final postList = response as Success<List<Post>>;
          final postCategorized =
              widget.vm.classifyPostsByCategory(postList.data);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _calculateCategoryPositions(postCategorized);
            widget.vm.updateCategoryPositions(_categoryPositions);
          });

          return ListView.builder(
            itemCount: postCategorized.length,
            controller: widget.vm.scrollController,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              String category = postCategorized.keys.elementAt(index);
              List<Post> postsInCategory = postCategorized[category]!;
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Column(
                        children:
                            List.generate(postsInCategory.length, (index) {
                      return PostListItem(postsInCategory[index], widget.vm,widget.vmCart);
                    })),
                  ],
                ),
              );
            },
          );
        }));
  }

  void _calculateCategoryPositions(Map<String, List<Post>> postCategorized) {
    double position = 0.0;
    _categoryPositions.clear();

    postCategorized.forEach((category, posts) {
      _categoryPositions[category] = position;
      position += _calculateCategoryHeight(category, posts);
    });
    // Añadimos un punto de depuración para verificar las posiciones calculadas
    print('Posiciones de categorías: $_categoryPositions');
  }

  double _calculateCategoryHeight(String category, List<Post> posts) {
    double categoryHeaderHeight = 30.0;
    double postItemHeight = 120.0;
    double padding = 13.0;

    return categoryHeaderHeight + (postItemHeight * posts.length) + padding;
  }
}
