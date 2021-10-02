import '../../../view/subViews/chatView/messageView.dart';
import '../../../view/widgets/customSearchBar.dart';
import '../../../view/widgets/customText.dart';
import '../../../const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List chats = [1];
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 36, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment(1, 0),
              child: IconButton(
                iconSize: 30,
                icon: Icon(Icons.close),
                onPressed: () => Get.back(),
                color: priColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: CustomText(
                txt: 'Messages',
                fSize: 30,
                fWeight: FontWeight.bold,
                txtColor: swatchColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomSearchBar(
              autoFocus: false,
              onChanged: (val) {},
              onTap: null,
              hintText: 'Search Coversations',
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: chats.isEmpty
                  ? Center(
                      child: Text('No Message !'),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      itemCount: chats.length,
                      itemBuilder: (context, i) => GestureDetector(
                        onTap: () => Get.to(() => MessageView()),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: CustomText(
                                txt: joinFirstTwoLetter('Smiley’s Store'),
                              ),
                            ),
                            SizedBox(width: 15),
                            Container(
                              width: size.width / 2,
                              padding: const EdgeInsets.only(top: 3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    txt: 'Smiley’s Store',
                                    fSize: 17,
                                    fWeight: FontWeight.w500,
                                  ),
                                  SizedBox(width: size.width * 0.3),
                                  CustomText(
                                    txt:
                                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
                                    fSize: 15,
                                    txtColor: swatchColor,
                                    maxLine: 2,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomText(
                                  txt: '9:20 AM',
                                  txtColor: swatchColor,
                                  fSize: 17,
                                ),
                                SizedBox(height: 10),
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: priColor,
                                  child: CustomText(
                                    txt: '5',
                                    txtColor: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      separatorBuilder: (context, i) => Divider(
                        color: Colors.grey,
                        indent: size.width * 0.18,
                        height: 30,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
