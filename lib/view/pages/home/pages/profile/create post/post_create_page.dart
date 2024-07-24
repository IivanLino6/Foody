import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/create%20post/posts_create_response.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/create%20post/widgets/post_create_content.dart';
import 'package:stripe_payment/view/pages/home/pages/profile/create%20post/post_create_viewmodel.dart';

class PostCreatePage extends StatelessWidget {
  const PostCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PostCreateViewModel>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PostsCreateResponse(context, vm);
    });
    return Scaffold(
        body: PostCreateContent(vm: vm),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    vm.createPost();
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    vm.resetState();
                  }),
            ),
          ],
        ));
  }
}
