import '../../view/widgets/customText.dart';
import '../../const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: CustomText(
                    txt: 'Notifications',
                    fSize: 30,
                    fWeight: FontWeight.bold,
                    txtColor: swatchColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemCount: 5,
                  itemBuilder: (context, i) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        notificationIcon[0],
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: CustomText(
                            txt:
                                'Smiley’s Store marked your order #1982984 as shipped',
                            fSize: 18,
                            maxLine: 3,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                txt: '9:20 AM',
                                txtColor: Colors.grey,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CircleAvatar(
                                radius: 7,
                                backgroundColor: priColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, i) => Divider(
                    color: Colors.grey,
                    indent: size.width * 0.16,
                    height: 30,
                  ),
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
