import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../helper/goTransittedPage.dart';
import '/view/subViews/chatView/chatView.dart';
import '/view/subViews/moreView/orderView/allOrdersView.dart';
import '/core/viewModel/authViewModel.dart';
import '/model/userModel.dart';
import '/model/notificationModel.dart';
import 'package:http/http.dart' as http;
import '/core/service/fireStore_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import '../../const.dart';
import 'moreViewModel.dart';

class NotificationViewModel extends GetxController {
  FirebaseMessaging fbMessaging = FirebaseMessaging.instance;
  AuthViewModel _authViewModel = Get.find();
  MoreViewModel _moreViewModel = Get.find();
  late List<Map<String, dynamic>> _tokens;
  List<NotificationModel> tempNotifications = [];
  onInit() {
    getDevicesToken();
    FirebaseMessaging.onMessageOpenedApp
        .listen((event) => handleNotifications(event.notification!.body!));
    fbMessaging.getInitialMessage().then((event) {
      if (event != null) {
        handleNotifications(event.notification!.body!);
      }
    });
    super.onInit();
  }

  getDevicesToken() {
    FireStoreNotification().getTokensfromFireStore().then((value) {
      _tokens = value.map((e) {
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        return {'id': e.id, 'token': data['token']};
      }).toList();
      update();
    });
  }

  addDeviceToken(String? uid) async {
    await fbMessaging
        .getToken(vapidKey: vapidKey)
        .then((value) => FireStoreNotification().addTokenToFireStore(
              uid,
              value,
            ));
  }

  Map<String, dynamic> getMangerTokens() {
    List<UserModel> mangerList =
        _authViewModel.users.where((user) => user.role == 'Manger').toList();
    List<Map<String, dynamic>> mangerTokens = [];
    mangerList.forEach((user) {
      mangerTokens =
          _tokens.where((element) => element['id'] == user.id).toList();
    });
    return {
      'ids': mangerTokens.map((e) => e['id']).toList(),
      'tokens': mangerTokens.map((e) => e['token']).toList()
    };
  }

  sendNotification(List<String?> uids, String body) async {
    List? userToken = uids.length == 1
        ? [
            _tokens
                .firstWhere((element) => element['id'] == uids.first)['token']
          ]
        : getMangerTokens()['tokens'];
    if (userToken != null) {
      userToken.forEach((element) async {
        await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverToken',
          },
          body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'body': body,
                'title': 'Notification',
                'sound': 'default',
              },
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'id': '1',
                'status': 'done'
              },
              'to': element,
            },
          ),
        );
      });
      FireStoreNotification().addNotificationToFireStore(
        NotificationModel(
          from: _moreViewModel.savedUser!.id,
          to: uids.length == 1 ? uids : getMangerTokens()['ids'],
          message: body,
          createdAt: Timestamp.now(),
          seen: false,
        ),
      );
    }
  }

  getTempNotifications(List<NotificationModel> notifications) {
    tempNotifications = notifications;
    update();
  }

  handleNotifications(String message) {
    if (message.contains('message')) {
      Go.to(() => ChatView());
    } else {
      Go.to(() => AllOrdersView());
    }
  }

  handleNotificationTapped(String? id, index, message) {
    handleNotifications(message);
    tempNotifications[index].seen = true;
    update();
    FireStoreNotification().updateSeenValue(id);
  }
}
