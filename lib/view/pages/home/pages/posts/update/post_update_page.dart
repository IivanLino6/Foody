import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/update/post_update_content.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/update/post_update_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/update/posts_update_response.dart';

class PostUpdatePage extends StatelessWidget {
  const PostUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    PostUpdateViewModel vm = Provider.of<PostUpdateViewModel>(context);

    Post postArgs = ModalRoute.of(context)?.settings.arguments as Post;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PostUpdateResponse(context, vm);
    }); // CUANDO TODOS LOS ELEMENTOS YA HAN SIDO MOSTRADOS EN PANATALLAS

    return Scaffold(
      body: FutureBuilder(
          future: vm.loadData(postArgs),
          builder: (context, _) => PostUpdateContent(vm, postArgs)),
    );
  }
}
