import '/core/viewModel/homeViewModel.dart';
import '/model/productModel.dart';
import '/view/subViews/productDetails/productDetails.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

class DynamicLinkHelper {
  FirebaseDynamicLinks _firebaseDynamicLinks = FirebaseDynamicLinks.instance;
  Future<Uri> createDynamicLink(String? id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://ecommerce77.page.link',
      link: Uri.parse('https://www.ecommerceApp.com/product?id=$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.ecommerce',
        minimumVersion: 1,
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.example.ecommerce',
        minimumVersion: '1',
        appStoreId: '123456789',
      ),
    );
    final ShortDynamicLink shortLink =
        await _firebaseDynamicLinks.buildShortLink(parameters);
    return shortLink.shortUrl;
  }

  Future<void> retrieveDynamicLink() async {
    //onBackground logic
    _firebaseDynamicLinks.onLink
        .listen((dynamicLink) => _navigationLogic(dynamicLink));
    //onTerminate logic
    _firebaseDynamicLinks
        .getInitialLink()
        .then((dynamicLink) => _navigationLogic(dynamicLink));
  }

  _navigationLogic(PendingDynamicLinkData? dynamicLink) {
    final Uri? deepLink = dynamicLink?.link;
    if (deepLink != null) {
      if (deepLink.pathSegments.contains('product')) {
        String? id = deepLink.queryParameters['id'];
        ProductModel prod = Get.find<HomeViewModel>()
            .products
            .firstWhere((prod) => prod.id == id);
        Get.to(
          () => ProductDetails(
            prod: prod,
            fromSearchView: false,
          ),
        );
      }
    }
  }
}
