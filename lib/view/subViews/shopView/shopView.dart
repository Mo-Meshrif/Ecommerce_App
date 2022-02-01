import '../../../model/productModel.dart';
import '../../../view/subViews/searchView/searchResultsView.dart';
import '../../../core/viewModel/homeViewModel.dart';
import '../../../model/categoryModel.dart';
import '../../../const.dart';
import 'package:get/get.dart';
import '../../widgets/customStackImg2IconTxt.dart';
import 'package:flutter/material.dart';
import 'shopPview.dart';
import 'shopTview.dart';

class ShopView extends StatelessWidget {
  final String cateTxt;
  ShopView({this.cateTxt});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: SafeArea(
            child: GetBuilder<HomeViewModel>(
              builder: (controller) {
                CategoryModel category = controller.categories
                    .firstWhere((element) => element.txt == cateTxt);
                List<ProductModel> prods = controller.products
                    .where((element) =>
                        element.classification['cat-id'] == category.id)
                    .toList();
                return category.shop['banner'] == ''
                    ? Center(
                        child: Text('Commming Soooooooooooooon !'),
                      )
                    : Column(
                        children: [
                          SizedBox(height: 3),
                          CustomStackImg2IconTxt(
                            banner: category.shop['banner'],
                            txtTitle: category.shop['txtTitle'],
                            txtDesc: category.shop['txtDesc'],
                            searchTap: () => Get.to(
                              () => SearchResultsView(
                                allProds: prods,
                              ),
                            ),
                          ),
                          TabBar(
                            unselectedLabelColor: Colors.black,
                            labelColor: priColor,
                            indicatorColor: priColor,
                            tabs: [
                              Tab(text: 'Products'),
                              Tab(text: 'Trending'),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                ShopPview(
                                  cat: category,
                                  products: prods,
                                ),
                                ShopTview(
                                  cat: category,
                                  products: prods,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
              },
            ),
          )),
    );
  }
}
