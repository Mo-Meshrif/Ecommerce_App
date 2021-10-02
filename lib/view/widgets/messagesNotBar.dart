import '../../view/subViews/chatView/chatView.dart';
import 'package:flutter/material.dart';
import 'customStackIcon.dart';
import 'package:get/get.dart';

class MessagesNotBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => Get.to(() => ChatView()),
          child: CustomStackIcon(
            imageUrl: 'assets/home/Messages.png',
            txtNum: '5',
          ),
        ),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () => null,
          child: CustomStackIcon(
            imageUrl: 'assets/home/notifications.png',
            txtNum: '10',
          ),
        ),
      ],
    );
  }
}
