import '../../../core/viewModel/homeViewModel.dart';
import '../../../model/categoryModel.dart';
import '../../../const.dart';
import 'package:get/get.dart';
import '../../widgets/customStackImg2IconTxt.dart';
import 'package:flutter/material.dart';
import 'shopPview.dart';
import 'shopRview.dart';

class ShopView extends StatelessWidget {
  final String cateTxt;
  ShopView({this.cateTxt});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(body: SafeArea(
        child: GetBuilder<HomeViewModel>(
          builder: (controller) {
            CategoryModel category = controller.categories
                .firstWhere((element) => element.txt == cateTxt);
            return category.shop['banner'] == ''
                ? Center(
                    child: Text('Commming Soooooooooooooon !'),
                  )
                : Column(
                    children: [
                      CustomStackImg2IconTxt(
                        banner: category.shop['banner'],
                        txtTitle: category.shop['txtTitle'],
                        txtDesc: category.shop['txtDesc'],
                      ),
                      TabBar(
                        unselectedLabelColor: Colors.black,
                        labelColor: priColor,
                        indicatorColor: priColor,
                        tabs: [
                          Tab(text: 'Products'),
                          Tab(text: 'Reviews'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ShopPview(cat: category),
                            ShopRview(),
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
