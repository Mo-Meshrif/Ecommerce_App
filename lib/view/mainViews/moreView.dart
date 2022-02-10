import 'package:cached_network_image/cached_network_image.dart';
import '../../core/service/fireStore_user.dart';
import '../../core/viewModel/searchViewModel.dart';
import '../../model/userModel.dart';
import '../../core/viewModel/moreViewModel.dart';
import '../../core/viewModel/authViewModel.dart';
import '../../view/widgets/customText.dart';
import '../../view/widgets/messagesNotBar.dart';
import '../widgets/moreCardBuilder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../const.dart';

class MoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MessagesNotBar(),
          GetBuilder<MoreViewModel>(
            builder: (moreController) {
              String uid, userName, email, pic;
              if (moreController.savedUser != null) {
                uid = moreController.savedUser.id;
                userName = moreController.savedUser.userName;
                email = moreController.savedUser.email;
                pic = moreController.savedUser.pic;
              }
              return Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(60)),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey,
                          backgroundImage: pic == null
                              ? AssetImage('assets/more/place_holder.jpg')
                              : CachedNetworkImageProvider(pic),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            return moreController
                                .getUserImage(
                                    user: UserModel(
                                  id: uid,
                                  userName: userName,
                                  email: email,
                                ))
                                .then((_) => moreController.getUserData());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20)),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey[100],
                              child: Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        txt: userName ?? '',
                        fSize: 30,
                        fWeight: FontWeight.bold,
                        txtColor: HexColor('#515C6F'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        txt: email ?? '',
                        fSize: 18,
                        fWeight: FontWeight.w500,
                        txtColor: HexColor('#515C6F'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          MediaQuery.of(context).size.height < 700
              ? Expanded(
                  child: MoreCardBuilder(
                    components: moreComponents,
                  ),
                )
              : Container(
                  height: 380,
                  child: MoreCardBuilder(
                    components: moreComponents,
                  )),
          SizedBox(
            height: 10,
          ),
          GetBuilder<AuthViewModel>(
            builder: (controller) => GetBuilder<SearchViewModel>(
              builder: (searchController) => Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    FireStoreUser().updateOnlineState(
                      Get.find<MoreViewModel>().savedUser.id,
                      false,
                    );
                    controller.logout();
                  },
                  child: CustomText(
                    txt: 'LOG OUT',
                    fWeight: FontWeight.w500,
                    txtColor: priColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
