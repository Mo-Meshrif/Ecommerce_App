import 'package:cached_network_image/cached_network_image.dart';
import '../../../helper/goTransittedPage.dart';
import '/responsive.dart';
import '../../../core/viewModel/moreViewModel.dart';
import '../../../core/viewModel/homeViewModel.dart';
import '../../../view/widgets/quantityChanger.dart';
import '../../../core/viewModel/cartViewModel.dart';
import '../../../model/cartProductModel.dart';
import '../../../view/mainViews/cartView.dart';
import '../../../core/viewModel/searchViewModel.dart';
import '../../../view/widgets/customElevatedButton.dart';
import '../../../model/productModel.dart';
import '../../../view/subViews/productDetails/productDetailsDview.dart';
import '../../../view/subViews/productDetails/productDetailsPview.dart';
import '../../../view/subViews/productDetails/productDetailsRview.dart';
import '../../../view/widgets/customStackIcon.dart';
import '../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel prod;
  final bool fromSearchView;
  ProductDetails({required this.prod, required this.fromSearchView});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(builder: (homeController) {
      homeController.createDynamicLink(prod.id);
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 33),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<SearchViewModel>(
                      builder: (searchController) => GetBuilder<MoreViewModel>(
                        builder: (moreController) => GestureDetector(
                            onTap: () {
                              if (fromSearchView) {
                                searchController.getRecentlyViewedProducts(
                                  ProductModel(
                                    id: prod.id,
                                    customerId: moreController.savedUser!.id,
                                    prodName: prod.prodName,
                                    imgUrl: prod.imgUrl,
                                    color: prod.color,
                                    size: prod.size,
                                    price: prod.price,
                                    createdAt: prod.createdAt,
                                    brand: prod.brand,
                                    condition: prod.condition,
                                    sku: prod.sku,
                                    material: prod.material,
                                    classification: prod.classification,
                                  ),
                                );
                              }
                              Get.back();
                              homeController.clearSelectedIndex();
                            },
                            child: Image.asset('assets/shop/back.png')),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: CustomText(
                            txt: prod.prodName,
                            fSize: 20,
                            fWeight: FontWeight.w300),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Go.to(() => CartView()),
                      child: GetBuilder<CartViewModel>(
                        builder: (cartController) => CustomStackIcon(
                          imageUrl: 'assets/shop/Cart.png',
                          txtNum: cartController.cartProds.length.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: CachedNetworkImage(
                    placeholder: (_, __) => Image.asset(
                      'assets/shop/place_holder.jpg',
                      fit: BoxFit.contain,
                    ),
                    imageUrl: prod.imgUrl!,
                    fit: BoxFit.contain,
                    errorWidget: (context, error, stackTrace) =>
                        Image.asset('assets/shop/place_holder.jpg'),
                  ),
                ),
                Responsive(
                  builder: (context, deviceInfo) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceInfo.screenWidth! / 18),
                    child: TabBar(
                      unselectedLabelColor: swatchColor,
                      labelColor: priColor,
                      indicatorColor: Colors.white10,
                      tabs: [
                        Tab(text: 'Product'),
                        Tab(text: 'Details'),
                        Tab(text: 'Reviews'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ProductDetailsPview(prod: prod),
                      ProductDetailsDview(prod: prod),
                      ProductDetailsRview(prod: prod)
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomElevatedButton(
                      buttonColor: Colors.white,
                      txt: 'SHARE THIS',
                      imgUrl: 'assets/shop/share_arrow.png',
                      txtColor: swatchColor,
                      onPress: homeController.getspecDynamicUrl(prod.id) != null
                          ? () async => await Share.share(
                                homeController.getspecDynamicUrl(prod.id)!,
                              )
                          : null,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    GetBuilder<CartViewModel>(builder: (cartController) {
                      List<CartProductModel> cartProds =
                          cartController.cartProds;
                      int cartProdIndex =
                          cartController.getCartProdIndex(prod.id);
                      return cartProdIndex == -1
                          ? GetBuilder<MoreViewModel>(
                              builder: (moreController) => Expanded(
                                child: CustomElevatedButton(
                                  txt: 'ADD TO CART',
                                  imgUrl: 'assets/auth/right_arrow.png',
                                  onPress: () => cartController.addProduct(
                                    cartProd: CartProductModel(
                                      id: prod.id,
                                      customerId: moreController.savedUser!.id,
                                      name: prod.prodName,
                                      imgUrl: prod.imgUrl,
                                      size: homeController.selectedSize ??
                                          prod.size![0],
                                      color: homeController.selectedColor ??
                                          prod.color![0],
                                      price: prod.price,
                                      quantity: 1,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Container(
                                padding: EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                    color: priColor,
                                    borderRadius: BorderRadius.circular(30)),
                                child: QuantityChanger(
                                  add: () => cartController
                                      .increaseQuantity(cartProdIndex),
                                  quantityVal:
                                      cartProds[cartProdIndex].quantity,
                                  minimize: () => cartController
                                      .decreaseQuantity(cartProdIndex, true),
                                  fromProdDetails: true,
                                ),
                              ),
                            );
                    })
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
