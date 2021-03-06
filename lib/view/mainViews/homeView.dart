import '../../helper/goTransittedPage.dart';
import '/responsive.dart';
import '/core/viewModel/moreViewModel.dart';
import '../../core/viewModel/chatViewModel.dart';
import '../../model/lastestCollectionModel.dart';
import '../../view/subViews/lastestCollectionView.dart';
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
    return GetBuilder<HomeViewModel>(
      builder: (controller) {
        List<CategoryModel> categories = controller.categories;
        List<ProductModel> products = controller.products;
        List<LastestCollectionModel> lastestCollections =
            controller.lastestCollections;
        MoreViewModel moreController=Get.find<MoreViewModel>();
        if(moreController.savedUser==null){
          moreController.getUserData();
        }
        //initialize searchViewModel,chatViewModel
        Get.put(SearchViewModel());
        Get.put(ChatViewModel());
        return categories.length < 3 
            ? Center(
                child: CustomText(
                  txt: 'HomeView',
                ),
              )
            : Responsive(
                builder: (context, deviceInfo) {
                  double lastProductFactor =
                      ((deviceInfo.screenHeight! - 458) / 120).floorToDouble();
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
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
                                    flex: 3,
                                    child: Row(
                                        children: categories
                                            .sublist(0, 3)
                                            .map(
                                              (cat) => Expanded(
                                                child: InkResponse(
                                                  radius: 25,
                                                  onTap: () => Go.to(
                                                    () => ShopView(
                                                      cateTxt: cat.txt,
                                                    ),
                                                  ),
                                                  child: CustomColTImage(
                                                    imgUrl: cat.imgUrl,
                                                    txt: cat.txt,
                                                    avatarCol: cat.avatarCol,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList()),
                                  ),
                                  Expanded(
                                    child: InkResponse(
                                      radius: 25,
                                      onTap: () => Go.to(
                                        () => CategoriesView(),
                                      ),
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
                          height: deviceInfo.screenHeight! * 0.25,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: lastestCollections.length,
                            itemBuilder: (context, i) => CustomStackImgTbutton(
                              fromlocal: false,
                              imgW: deviceInfo.screenWidth,
                              imgH: deviceInfo.screenHeight! * 0.25,
                              imgUrl: lastestCollections[i].imgUrl,
                              txt: lastestCollections[i].title,
                              onTap: () => Go.to(
                                () => LastestCollectionView(
                                  allProducts: products,
                                  season: lastestCollections[i].season,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: lastProductFactor.toInt() > 3
                                  ? lastProductFactor.toInt()
                                  : 3,
                              mainAxisExtent: 130,
                            ),
                            children: products
                                .map((prod) => products.indexOf(prod) <
                                        lastProductFactor * 3
                                    ? GestureDetector(
                                        onTap: () => Go.to(
                                          () => ProductDetails(
                                            prod: prod,
                                            fromSearchView: false,
                                          ),
                                        ),
                                        child: CustomColumImgTT(
                                          imgUrl: prod.imgUrl,
                                          txt1: prod.prodName,
                                          txt2: '\$' + prod.price!,
                                        ),
                                      )
                                    : Padding(padding: EdgeInsets.zero))
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}
