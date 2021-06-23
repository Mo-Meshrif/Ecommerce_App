import '../../../view/subViews/productsView.dart';
import '../../../view/widgets/customSearchBar.dart';
import 'package:flutter/material.dart';
import '../../../core/viewModel/searchViewModel.dart';
import 'package:get/get.dart';
import '../../../const.dart';
import '../../../view/widgets/customRTxtGTxt.dart';
import '../../../view/widgets/customText.dart';
import '../../../view/widgets/messagesNotBar.dart';

class SearchHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
      child: GetBuilder<SearchViewModel>(
        builder: (controller) {
          List<String> recommendedCats = controller.recommendedCats;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MessagesNotBar(),
              SizedBox(height: 15),
              CustomText(
                txt: 'Search',
                txtColor: swatchColor,
                fSize: 30,
                fWeight: FontWeight.bold,
              ),
              SizedBox(height: 20),
              CustomSearchBar(
                autoFocus: false,
                onChanged: (val) => controller.getSearchedProducts(val),
                onTap: () => controller.changeSearchState(true),
              ),
              SizedBox(height: 20),
              CustomRTxtGTxt(
                txt1: 'RECENTLY VIEWED',
                txt2: 'CLEAR',
                onT: () => null,
              ),
              SizedBox(height: 15),
              Container(
                height: 80,
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/home/backpack.png',
                            height: 40,
                            width: 40,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                txt: 'Bottle Green Backpack',
                              ),
                              CustomText(
                                txt: '\$20.58',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomRTxtGTxt(
                txt1: 'RECOMMENDED',
                txt2: 'REFRESH',
                onT: () => controller.shuffleRecommendedCats(),
              ),
              SizedBox(height: 15),
              LimitedBox(
                maxHeight: 100,
                child: GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount:
                        recommendedCats.length < 6 ? recommendedCats.length : 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 50,
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, x) => GestureDetector(
                          onTap: () => Get.to(() => ProductsView(
                                prodsTxt: recommendedCats[x],
                                fromCategoriesView: false,
                              )),
                          child: Card(
                            child: Center(
                              child: CustomText(
                                txt: recommendedCats[x],
                              ),
                            ),
                          ),
                        )),
              )
            ],
          );
        },
      ),
    );
  }
}
