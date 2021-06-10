import '../../../const.dart';
import '../../../core/viewModel/categoriesViewModel.dart';
import 'package:get/get.dart';
import '../../widgets/customStackImg2IconTxt.dart';
import 'package:flutter/material.dart';
import 'shopPview.dart';
import 'shopRview.dart';
import 'shopHView.dart';

class ShopView extends StatelessWidget {
  final String gatoTxt;

  ShopView({this.gatoTxt});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: SafeArea(
        child: GetBuilder<CategoriesViewModel>(
          init: CategoriesViewModel(),
          builder: (controller) {
            final category = controller.categories
                .firstWhere((element) => element['txt'] == gatoTxt);
            return category['shop'] == null
                ? Center(
                    child: Text('Commming Soooooooooooooon !'),
                  )
                : Column(
                    children: [
                      CustomStackImg2IconTxt(
                        banner: category['shop']['banner'],
                        txtTitle: category['shop']['txtTitle'],
                        txtDesc: category['shop']['txtDesc'],
                      ),
                      TabBar(
                        unselectedLabelColor: Colors.black,
                        labelColor: priColor,
                        indicatorColor: priColor,
                        tabs: [
                          Tab(text: 'Home'),
                          Tab(text: 'Products'),
                          Tab(text: 'Reviews'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ShopHview(),
                            ShopPview(),
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
