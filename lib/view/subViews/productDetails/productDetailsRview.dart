import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/core/viewModel/authViewModel.dart';
import '/model/userModel.dart';
import '../../../core/viewModel/moreViewModel.dart';
import '../../../model/rewiewModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../core/viewModel/homeViewModel.dart';
import '../../../const.dart';
import '../../../model/productModel.dart';
import '../../../view/widgets/customText.dart';
import '../../../view/widgets/reviews.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductDetailsRview extends StatelessWidget {
  final ProductModel prod;
  ProductDetailsRview({required this.prod});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (homeController) => Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Reviews')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  List<DocumentSnapshot> rewviewsSnap = snapshot.hasData
                      ? (snapshot.data as QuerySnapshot).docs
                      : [];
                  List<ReviewModel> filteredReviews = rewviewsSnap
                      .map((review) => ReviewModel.fromJson(
                          review.id, review.data() as Map<String, dynamic>))
                      .where((element) => element.prodId == prod.id)
                      .toList();
                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: filteredReviews.length,
                    itemBuilder: (context, i) {
                      UserModel user = Get.find<AuthViewModel>()
                          .users
                          .firstWhere(
                              (user) => user.id == filteredReviews[i].userId);
                      return filteredReviews[i].userId ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? Dismissible(
                              key: Key(filteredReviews[i].reviewId.toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20),
                                color: Colors.red,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.delete, color: Colors.white),
                                    Text('Delete',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                              onDismissed: (_) => homeController.deleteReview(
                                filteredReviews[i].reviewId.toString(),
                              ),
                              child: Reviews(
                                name: user.userName,
                                date: DateFormat('yyyy-MM-dd hh:mm')
                                    .format(
                                        filteredReviews[i].createdAt!.toDate())
                                    .toString(),
                                reviewDetails: filteredReviews[i].reviewTxt,
                                rateValue: filteredReviews[i].rateValue ?? 0,
                              ),
                            )
                          : Reviews(
                              name: user.userName,
                              date: DateFormat('yyyy-MM-dd hh:mm')
                                  .format(
                                      filteredReviews[i].createdAt!.toDate())
                                  .toString(),
                              reviewDetails: filteredReviews[i].reviewTxt,
                              rateValue: filteredReviews[i].rateValue ?? 0,
                            );
                    },
                    separatorBuilder: (context, i) => SizedBox(
                      height: 10,
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => Get.bottomSheet(
                homeController.reviewloading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: CustomText(
                                    txt: 'Cancel',
                                    fSize: 20,
                                    txtColor: priColor,
                                  ),
                                ),
                                CustomText(
                                  txt: 'Write a Review',
                                  fSize: 20,
                                ),
                                GetBuilder<MoreViewModel>(
                                  builder: (moreController) => GestureDetector(
                                    onTap: homeController.reviewText != null
                                        ? () {
                                            homeController.addReview(
                                              prod.id,
                                              prod.imgUrl,
                                              moreController.savedUser!,
                                            );
                                            Get.back();
                                          }
                                        : () => Get.snackbar(
                                              'Error',
                                              'Your review is Empty !',
                                              snackPosition: SnackPosition.BOTTOM,
                                              duration: Duration(seconds: 2),
                                            ),
                                    child: CustomText(
                                      txt: 'Send',
                                      fSize: 20,
                                      txtColor: priColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 35,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: priColor,
                              ),
                              onRatingUpdate: (rating) =>
                                  homeController.rateValue = rating,
                            ),
                            CustomText(
                              txt: 'Tap a Star to Rate',
                            ),
                            Divider(),
                            Expanded(
                              child: TextFormField(
                                expands: true,
                                minLines: null,
                                maxLines: null,
                                onChanged: (val) =>
                                    homeController.reviewText = val,
                                validator: (val) => null,
                                decoration: InputDecoration(
                                    hintText: 'Review',
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none),
                              ),
                            )
                          ],
                        ),
                      ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)))),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.message),
                SizedBox(
                  width: 10,
                ),
                CustomText(
                  txt: 'Write Review',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
