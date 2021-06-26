import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import '../../core/viewModel/searchViewModel.dart';
import '../../view/subViews/searchView/searchHomeView.dart';
import '../../view/subViews/searchView/searchResultsView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<SliderMenuContainerState> searchKey =
        new GlobalKey<SliderMenuContainerState>();
    return GetBuilder<SearchViewModel>(
        init: SearchViewModel(),
        builder: (controller) => !controller.isSearchResultsView.value
            ? SearchHomeView()
            : SliderMenuContainer(
                key: searchKey,
                sliderMain: SearchResultsView(searchRkey: searchKey),
                sliderMenu: null,
                sliderMenuOpenSize: 120,
                slideDirection: SlideDirection.TOP_TO_BOTTOM,
                hasAppBar: false,
              ));
  }
}
