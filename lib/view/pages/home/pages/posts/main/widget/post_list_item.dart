import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:popover/popover.dart';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/main/post_list_viewmodel.dart';
import 'package:stripe_payment/widgets/custom_container.dart';

class PostListItem extends StatefulWidget {
  Post post;
  PostListViewModel vm;
  CartViewModel vmCart;
  PostListItem(this.post, this.vm,this.vmCart);

  @override
  State<PostListItem> createState() => _PostListItemState();
}

class _PostListItemState extends State<PostListItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              //White background
              Container(
            height: 110,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(25.0), // Set radius for rounded corners
              color: Colors.white, // Set background color
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2), // Shadow color
                  offset: Offset(0, 3), // Shadow offset
                  blurRadius: 5.0, // Shadow blur radius
                  spreadRadius: 2.0, // Shadow spread radius
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        //Image
                        Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                widget.vm.concatImage(widget.post)),
                            fit: BoxFit.cover),
                      ),
                      width: 100,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Expanded(
                        child: Text(
                          widget.post.description,
                          maxLines: 3,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      Text(widget.post.price)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      Positioned(
        top: 10,
        right: 15,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              print('Press');
              showPopover(
                  context: context,
                  bodyBuilder: (context) => MyPopUpMenu(widget.post, widget.vm),
                  direction: PopoverDirection.bottom,
                  width: 170,
                  height: 90,
                  arrowHeight: 0,
                  arrowWidth: 0,
                  backgroundColor: Colors.white,
                  shadow: CupertinoContextMenu.kEndBoxShadow,
                  arrowDxOffset: 0,
                  arrowDyOffset: 0,
                  contentDxOffset: 0,
                  contentDyOffset: 0);
            },
            child: const Icon(
              Icons.more_vert,
              size: 18,
            ),
          ),
        ),
      ),
      //Actions Buttons
      Positioned(
          top: 85,
          right: 15,
          child: Row(
            children: [
              //Add Button
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Ajusta el radio según tus preferencias
                      ),
                      backgroundColor: Colors.white,
                      child: Icon(
                        widget.vmCart.isSelected(widget.post)
                            ? Icons.check
                            : Icons.add,
                        size: 16,
                      ),
                      onPressed: () {
                        widget.vm.addtoCart(widget.post, context);
                        widget.vmCart.selectedItems(widget.post);
                      }),
                ),
              ),
            ],
          ))
    ]);
  }
}

class MyPopUpMenu extends StatelessWidget {
  final Post post;
  PostListViewModel vm;
  MyPopUpMenu(this.post, this.vm);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        GestureDetector(
          onTap: () {
            vm.deletePost(post.id);
            Navigator.pop(context);
          },
          child: const Row(
            children: [
              CircleAvatar(
                maxRadius: 16,
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Delete',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'PostUpdatePage', arguments: post);
          },
          child: const Row(
            children: [
              CircleAvatar(
                maxRadius: 16,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Edit',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
