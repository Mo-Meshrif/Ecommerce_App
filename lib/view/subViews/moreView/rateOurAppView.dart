import '../../../core/viewModel/moreViewModel.dart';
import '../../../view/widgets/customText.dart';
import '../../../const.dart';
import '../../../view/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateOurAppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Rate Our App',
          backFun: () => Get.back(),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Image.asset(
                  'assets/more/rate_banner.png',
                ),
              ),
              CustomText(
                txt: 'Your opinion matters to us !',
                fSize: 25,
                fWeight: FontWeight.bold,
              ),
              SizedBox(height: 10),
              CustomText(
                txt: 'We work super hard to make Glose',
                fSize: 17,
                txtColor: Colors.grey[600],
              ),
              CustomText(
                txt: 'better for you,and would love to know :',
                fSize: 17,
                txtColor: Colors.grey[600],
              ),
              CustomText(
                txt: 'how would you rate our app ?',
                fSize: 17,
                txtColor: Colors.grey[600],
              ),
              SizedBox(height: 15),
              GetBuilder<MoreViewModel>(
                builder: (moreController) => RatingBar.builder(
                  initialRating: moreController.appRateValue,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 40,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: priColor,
                  ),
                  onRatingUpdate: (rating) =>
                      moreController.setAppRateValue(rating),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ));
  }
}
