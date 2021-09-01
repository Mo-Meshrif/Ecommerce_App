import '../../model/userModel.dart';
import '../../core/viewModel/homeViewModel.dart';
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
      padding: EdgeInsets.only(top: 35, bottom: 10, right: 25, left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MessagesNotBar(),
          GetBuilder<HomeViewModel>(
            builder: (homeController) {
              String uid = homeController.userId;
              String userName = homeController.userName;
              String email = homeController.email;
              String pic = homeController.pic;
              homeController.getUserDate();
              return Row(
                children: [
                  GetBuilder<MoreViewModel>(
                    builder: (moreController) => Stack(
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
                                : NetworkImage(pic),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              return moreController.getUserImage(
                                  user: UserModel(
                                id: uid,
                                userName: userName,
                                email: email,
                              ));
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
          Expanded(
            child: MoreCardBuilder(
              initialIndex: 0,
              components: moreComponents,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: MoreCardBuilder(
              initialIndex: 3,
              components: moreComponents,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GetBuilder<AuthViewModel>(
            builder: (controller) => Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => controller.logout(),
                child: CustomText(
                  txt: 'LOG OUT',
                  fWeight: FontWeight.w500,
                  txtColor: priColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
