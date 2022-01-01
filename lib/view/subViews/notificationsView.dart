import '/core/viewModel/notificationViewModel.dart';
import '/model/notificationModel.dart';
import '../../view/widgets/customText.dart';
import '../../const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<NotificationViewModel>(
        builder: (notificationController) {
          List<NotificationModel> notifications =
              notificationController.tempNotifications;
          return Container(
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
                        child: notifications.isEmpty
                            ? Center(
                                child: CustomText(
                                  txt: "You haven't any notifications !",
                                  fSize: 20,
                                ),
                              )
                            : ListView.separated(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                itemCount: notifications.length,
                                itemBuilder: (context, i) {
                                  String message = notifications[i].message;
                                  int x = message.contains('destination')
                                      ? 1
                                      : message.contains('order')
                                          ? 0
                                          : 2;
                                  return GestureDetector(
                                    onTap: () =>
                                        Get.find<NotificationViewModel>()
                                            .handleNotificationTapped(
                                      notifications[i].id,
                                      i,
                                      message,
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: CircleAvatar(
                                        radius: 25,
                                        child: Image.asset(
                                          notificationIcon[x],
                                        ),
                                      ),
                                      title: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: CustomText(
                                              txt: message,
                                              fSize: 18,
                                              maxLine: 3,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                CustomText(
                                                  txt: DateFormat('hh:mm a')
                                                      .format(
                                                    notifications[i]
                                                        .createdAt
                                                        .toDate(),
                                                  ),
                                                  txtColor: Colors.grey,
                                                ),
                                                notifications[i].seen
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 18))
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 3),
                                                        child: CircleAvatar(
                                                          radius: 7,
                                                          backgroundColor:
                                                              priColor,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
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
          );
        },
      ),
    );
  }
}
