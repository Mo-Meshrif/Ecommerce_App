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
          SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/more/place_holder.jpg'),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    txt: 'Mo Meshrif',
                    fSize: 30,
                    fWeight: FontWeight.bold,
                    txtColor: HexColor('#515C6F'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    txt: 'm.meshrif77@gmail.com',
                    fSize: 18,
                    fWeight: FontWeight.w500,
                    txtColor: HexColor('#515C6F'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: HexColor('#727C8E')),
                        borderRadius: BorderRadius.circular(20)),
                    child: CustomText(
                      txt: 'EDIT PROFILE',
                      fSize: 15,
                      fWeight: FontWeight.bold,
                      txtColor: HexColor('#515C6F'),
                    ),
                  ),
                ],
              ),
            ],
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
