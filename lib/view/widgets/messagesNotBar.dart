import '../../view/subViews/notificationsView.dart';
import '../../core/viewModel/chatViewModel.dart';
import '../../core/viewModel/moreViewModel.dart';
import '../../model/lastChatModel.dart';
import '../../view/subViews/chatView/chatView.dart';
import 'package:flutter/material.dart';
import 'customStackIcon.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesNotBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String customerId = Get.find<MoreViewModel>().savedUser.id;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Chats').snapshots(),
            builder: (context, chatSnap) {
              if (chatSnap.hasData) {
                Get.find<ChatViewModel>().getLastChats();
              }
              return GetBuilder<ChatViewModel>(
                builder: (chatController) {
                  List<LastChatModel> unOpenedChats = chatController.lastchats
                      .where((element) =>
                          element.isOpened == false &&
                          element.to.id == customerId)
                      .toList();
                  return GestureDetector(
                    onTap: () => Get.to(() => ChatView()),
                    child: CustomStackIcon(
                      imageUrl: 'assets/home/Messages.png',
                      txtNum: unOpenedChats.length.toString(),
                    ),
                  );
                },
              );
            }),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () => Get.to(() => NotificationsView()),
          child: CustomStackIcon(
            imageUrl: 'assets/home/notifications.png',
            txtNum: '10',
          ),
        ),
      ],
    );
  }
}
