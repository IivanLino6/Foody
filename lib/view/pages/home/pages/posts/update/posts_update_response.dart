import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:stripe_payment/utils/show_dialog.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/update/post_update_viewmodel.dart';

class PostUpdateResponse {

  BuildContext context;
  PostUpdateViewModel vm;

  PostUpdateResponse(this.context, this.vm) {
    if (vm.response is Loading) {
      buildShowDialog(context);
    }
    else if (vm.response is Error) {
      final data = vm.response as Error;
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: data.error,
        timeInSecForIosWeb: 3,
        toastLength: Toast.LENGTH_LONG
      );
      vm.resetResponse();
    }
    else if (vm.response is Success) {
      final success = vm.response as Success<String>;
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: success.data,
        timeInSecForIosWeb: 3,
        toastLength: Toast.LENGTH_LONG
      );
      Navigator.pop(context);
      Navigator.pop(context);
      vm.resetResponse();
    }
  }

}