import '../../../core/viewModel/searchViewModel.dart';
import '../../../view/widgets/customSearchBar.dart';
import '../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 21, vertical: 45),
      child: GetBuilder<SearchViewModel>(
        builder: (controller) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => controller.changeSearchState(false),
                    child: Image.asset('assets/shop/back.png'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: CustomSearchBar(
                      autoFocus: true,
                      onChanged: (val) => controller.getSearchedProducts(val),
                      onTap: null,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () => null,
                    child: Image.asset(
                      'assets/shop/filter.png',
                      color: null,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    txt: 'BEST MATCH',
                  ),
                  CustomText(
                    txt: 'PRICE LOW-HIGH',
                  ),
                  CustomText(
                    txt: 'PRICE HIGH-LOW',
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
