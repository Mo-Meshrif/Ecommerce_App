import '../../../core/viewModel/searchViewModel.dart';
import '../../../model/productModel.dart';
import '../productDetails/productDetails.dart';
import '../../widgets/customColumImgTT.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchRSortView extends StatelessWidget {
  final List<ProductModel> products;

  SearchRSortView({@required this.products});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: products.length,
        itemBuilder: (context, x) => GetBuilder<SearchViewModel>(
          builder: (controller) => GestureDetector(
            onTap: () => Get.to(() => ProductDetails(
                  prod: products[x],
                  fromSearchView: true,
                )),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: CustomColumImgTT(
                  imgUrl: products[x].imgUrl,
                  txt1: products[x].prodName,
                  txt2: '\$' + products[x].price,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
