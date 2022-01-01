import '/core/viewModel/notificationViewModel.dart';
import '/model/notificationModel.dart';
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
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Notifications')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              List<DocumentSnapshot> notificationsSnap =
                  snapshot.hasData ? snapshot.data.docs : [];
              List<NotificationModel> notifications = notificationsSnap
                  .map(
                    (e) => NotificationModel.fromJson(
                      e.id,
                      e.data(),
                    ),
                  )
                  .where((notify) =>
                      notify.to.indexOf(customerId) >= 0 &&
                      !notify.message.contains('message'))
                  .toList();
              int notSeenLength =
                  notifications.where((notify) => !notify.seen).toList().length;
              return GetBuilder<NotificationViewModel>(
                init:NotificationViewModel() ,
                builder: (notificationController) => GestureDetector(
                  onTap: () {
                    notificationController.getTempNotifications(notifications);
                    Get.to(() => NotificationsView());
                  },
                  child: CustomStackIcon(
                    imageUrl: 'assets/home/notifications.png',
                    txtNum: notSeenLength.toString(),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
