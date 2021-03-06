import '/model/userModel.dart';
import '../../helper/goTransittedPage.dart';
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
    UserModel? userModel = Get.find<MoreViewModel>().savedUser;
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
                  List<LastChatModel> unOpenedChats = userModel != null
                      ? chatController.lastchats
                          .where((element) =>
                              element.isOpened == false &&
                              element.to!.id == userModel.id)
                          .toList()
                      : [];
                  return GestureDetector(
                    onTap: () => Go.to(() => ChatView()),
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
                  snapshot.hasData ? (snapshot.data as QuerySnapshot).docs : [];
              List<NotificationModel> notifications = userModel != null
                  ? notificationsSnap
                      .map(
                        (e) => NotificationModel.fromJson(
                          e.id,
                          e.data() as Map<String, dynamic>?,
                        ),
                      )
                      .where((notify) =>
                          notify.to!.indexOf(userModel.id) >= 0 &&
                          !notify.message!.contains('message'))
                      .toList()
                  : [];
              int notSeenLength = notifications
                  .where((notify) => !notify.seen!)
                  .toList()
                  .length;
              return GetBuilder<NotificationViewModel>(
                init: NotificationViewModel(),
                builder: (notificationController) => GestureDetector(
                  onTap: () {
                    notificationController.getTempNotifications(notifications);
                    Go.to(() => NotificationsView());
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
