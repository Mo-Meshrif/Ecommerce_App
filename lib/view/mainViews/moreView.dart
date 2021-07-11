import '../../core/viewModel/authViewModel.dart';
import '../../view/widgets/customText.dart';
import '../../view/widgets/messagesNotBar.dart';
import '../../view/widgets/profileMoreCardBuilder.dart';
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
          SizedBox(
            height: 15,
          ),
          CustomText(
            txt: 'More',
            fSize: 30,
            fWeight: FontWeight.bold,
            txtColor: HexColor('#515C6F'),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ProfileMoreCardBuilder(
              initialIndex: 0,
              components: moreComponents,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ProfileMoreCardBuilder(
              initialIndex: 4,
              components: moreComponents,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GetBuilder<AuthViewModel>(
            builder: (controller) => Container(
              padding: EdgeInsets.all(20),
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
