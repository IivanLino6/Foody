import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/domain/model/food_categories.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/main/post_list_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/posts/main/widget/post_list_content.dart';
import 'package:stripe_payment/widgets/custom_container.dart';
import 'package:stripe_payment/widgets/text_field.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PostListViewModel _vm;

  @override
  void initState() {
    super.initState();
    // Inicializar el TabController con el número de pestañas
    _vm = Provider.of<PostListViewModel>(context, listen: false);
    _tabController =
        TabController(length: foodWidgetCategories.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      _vm.selectCategory(_tabController.index);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PostListViewModel>(context);
    return Stack(children: [
      Positioned.fill(
          bottom: 110,
          child: Image.asset(
            'asset/salad.jpg',
            fit: BoxFit.cover,
          )),
      //White Background
      Container(
          width: double.infinity,
          margin:
              const EdgeInsets.only(top: 110), // Ajusta según tus necesidades
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40)) // Esquinas redondeadas
              ),
          child: Column(children: [
            //FoddyApp title
            const Padding(
              padding: EdgeInsets.only(left: 25, top: 20),
              child:
                  //Foody title, filter btn
                  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Foody',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text(
                    'App',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.blue),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 18),
                          child: MyContainer(
                              height: 35,
                              width: 100,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.filter,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                  ),
                                  Text(
                                    '  Filter by',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            //Search
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: DefaultFormField(txt: 'Search', onChanged: (_) {}),
            ),
            //Tab category selector
            TabBar(
                onTap: (index) {
                  //vm.selectCategory(index);
                },
                indicatorColor: Colors.blue,
                labelColor: Colors.black,
                controller: _tabController,
                isScrollable: true,
                tabs: List.generate(foodWidgetCategories.length, (index) {
                  var category = foodWidgetCategories[index];
                  return Container(
                    height: 40,
                    width: 85,
                    child: Center(child: Text(category["title"])),
                  );
                })),
            //Category
            Expanded(child: Container(child: PostListContent(vm))),
          ]))
    ]);
  }
}
