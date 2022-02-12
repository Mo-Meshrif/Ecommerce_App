import '/core/viewModel/notificationViewModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'customText.dart';
import 'customTextButton.dart';

class OnMessageNotify extends StatelessWidget {
  final RemoteNotification? notification;

  OnMessageNotify({required this.notification});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: CustomText(
        txt: 'Alert',
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            txt: notification!.body,
            maxLine: 3,
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                txt: 'Dismiss',
                buttonColor: Colors.red,
                onPress: () => Navigator.pop(context),
              ),
              GetBuilder<NotificationViewModel>(
                builder: (notificationController) => CustomTextButton(
                  txt: 'Details',
                  onPress: () {
                    Navigator.pop(context);
                    notificationController
                        .handleNotifications(notification!.body!);
                  },
                  buttonColor: Colors.green,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
