import '../../core/viewModel/cartViewModel.dart';
import '../../core/viewModel/moreViewModel.dart';
import '../../view/subViews/shopView/shopView.dart';
import '../subViews/categoriesView.dart';
import '../../core/viewModel/searchViewModel.dart';
import '../../view/widgets/messagesNotBar.dart';
import '../../view/subViews/productDetails/productDetails.dart';
import '../../core/viewModel/homeViewModel.dart';
import '../../model/categoryModel.dart';
import '../../model/productModel.dart';
import 'package:get/get.dart';
import '../widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../widgets/customColTImage.dart';
import '../widgets/customColumImgTT.dart';
import '../widgets/customStackImgTbutton.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
      child: GetBuilder<HomeViewModel>(
        builder: (controller) {
          final MoreViewModel _moreContrroler = Get.find();
          final CartViewModel _cartViewModel = Get.find();
          if (_moreContrroler.savedUser == null) {
            _moreContrroler
                .getUserData()
                .then((_) => _cartViewModel.getProducts());
          }
          List<CategoryModel> categories = controller.categories;
          List<ProductModel> products = controller.products;
          List<Widget> lastHomeProducts = <Widget>[];
          if (products.length > 3) {
            for (var i = 0; i < 3; i++) {
              lastHomeProducts.add(new GestureDetector(
                onTap: () => Get.to(() => ProductDetails(
                      prod: products[i],
                      fromSearchView: false,
                    )),
                child: CustomColumImgTT(
                  imgUrl: products[i].imgUrl,
                  txt1: products[i].prodName,
                  txt2: '\$' + products[i].price,
                ),
              ));
            }
          }
          //initialize searchViewModel
          Get.put(SearchViewModel());
          return categories.length < 3
              ? Center(
                  child: CustomText(
                    txt: 'HomeView',
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MessagesNotBar(),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      txt: 'Categories',
                      fSize: 30,
                      txtColor: HexColor('#515C6F'),
                      fWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    categories.length == 0
                        ? Padding(padding: EdgeInsets.all(0))
                        : Row(
                            children: [
                              Expanded(
                                child: InkResponse(
                                  radius: 25,
                                  onTap: () => Get.to(() =>
                                      ShopView(cateTxt: categories[0].txt)),
                                  child: CustomColTImage(
                                    imgUrl: categories[0].imgUrl,
                                    txt: categories[0].txt,
                                    avatarCol: categories[0].avatarCol,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkResponse(
                                  radius: 25,
                                  onTap: () => Get.to(() =>
                                      ShopView(cateTxt: categories[1].txt)),
                                  child: CustomColTImage(
                                    imgUrl: categories[1].imgUrl,
                                    txt: categories[1].txt,
                                    avatarCol: categories[1].avatarCol,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkResponse(
                                  radius: 25,
                                  onTap: () => Get.to(() =>
                                      ShopView(cateTxt: categories[2].txt)),
                                  child: CustomColTImage(
                                    imgUrl: categories[2].imgUrl,
                                    txt: categories[2].txt,
                                    avatarCol: categories[2].avatarCol,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkResponse(
                                  radius: 25,
                                  onTap: () => Get.to(() => CategoriesView()),
                                  child: CustomColTImage(
                                    imgUrl: 'assets/home/right_arrow_h.png',
                                    txt: 'See All',
                                    avatarCol: '#FFFFFF',
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      txt: 'Latest',
                      fSize: 30,
                      txtColor: HexColor('#515C6F'),
                      fWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 190,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, i) => GestureDetector(
                          onTap: null,
                          child: CustomStackImgTbutton(
                            imgUrl: 'assets/home/banner.png',
                            txt: 'For all your \nsummer clothing \nneeds',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: lastHomeProducts,
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
