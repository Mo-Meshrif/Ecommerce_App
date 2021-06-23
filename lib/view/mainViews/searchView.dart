import '../../core/viewModel/searchViewModel.dart';
import '../../view/subViews/searchView/searchHomeView.dart';
import '../../view/subViews/searchView/searchResultsView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchViewModel>(
        init: SearchViewModel(),
        builder: (controller) => !controller.isSearchResultsView.value
            ? SearchHomeView()
            : SearchResultsView());
  }
}
