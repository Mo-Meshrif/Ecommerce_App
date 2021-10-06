import '../../../core/viewModel/chatViewModel.dart';
import '../../../core/viewModel/cartViewModel.dart';
import '../../../model/orderModel.dart';
import '../../../model/userModel.dart';
import '../../../view/widgets/customText.dart';
import '../../../const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class MessageView extends StatelessWidget {
  final UserModel customer;
  final UserModel shippingCompany;
  final int orderNumber;
  MessageView({
    @required this.shippingCompany,
    @required this.orderNumber,
    @required this.customer,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _messageController = new TextEditingController();
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          List data = [];
          if (snapshot.hasData) {
            data = snapshot.data.docs;
          }
          List chats = data
              .where((element) => element['orderNumber'] == orderNumber)
              .toList();
          return GetBuilder<ChatViewModel>(
            builder: (chatController) => Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 36, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.find<ChatViewModel>()
                                      .restClickedMessageNumber();
                                  Get.back();
                                },
                                child: Image.asset('assets/shop/back.png')),
                            SizedBox(width: 30),
                            Expanded(
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: CustomText(
                                  txt: shippingCompany.userName,
                                  fSize: 17,
                                ),
                                subtitle: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Users')
                                      .snapshots(),
                                  builder: (context, userSnap) {
                                    List users = [];
                                    if (userSnap.hasData) {
                                      users = userSnap.data.docs;
                                    }
                                    bool shippingCompIsOnline = users.length > 0
                                        ? users.firstWhere((element) =>
                                            element['id'] ==
                                            shippingCompany.id)['isOnline']
                                        : null;
                                    return userSnap.hasData
                                        ? CustomText(
                                            txt: shippingCompIsOnline
                                                ? 'Active'
                                                : 'Offline',
                                          )
                                        : Padding(padding: EdgeInsets.zero);
                                  },
                                ),
                                trailing: CircleAvatar(
                                  radius: 20,
                                  child: CustomText(
                                    txt: joinFirstTwoLetter(
                                        shippingCompany.userName),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GetBuilder<CartViewModel>(
                            builder: (cartController) {
                              OrderModel myOrder = cartController.allOrders
                                  .firstWhere((element) =>
                                      element.orderNumber == orderNumber);
                              return ExpansionTile(
                                tilePadding: EdgeInsets.zero,
                                title: CustomText(
                                  txt: 'Order: #' + orderNumber.toString(),
                                  txtColor: swatchColor,
                                  fWeight: FontWeight.bold,
                                  fSize: 17,
                                ),
                                children: myOrder.items
                                    .map(
                                      (e) => Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 35,
                                            backgroundColor: Colors.white,
                                            child: Image.network(
                                              e['imgUrl'],
                                              height: 50,
                                              width: 60,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  CustomText(
                                                    txt: e['name'] +
                                                        ', ' +
                                                        e['size'] +
                                                        ', ',
                                                    fSize: 17,
                                                  ),
                                                  Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          HexColor(e['color']),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              CustomText(
                                                txt: e['price'],
                                                txtColor: priColor,
                                                fSize: 17,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                    .toList(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        color: HexColor('#F5F6F8'),
                        child: ListView.separated(
                          reverse: true,
                          padding: EdgeInsets.all(20),
                          itemCount: chats.length,
                          itemBuilder: (context, i) {
                            Timestamp messageTime = chats[i]['createdAt'];
                            return Column(
                              crossAxisAlignment:
                                  chats[i]['from'] != shippingCompany.id
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                              children: [
                                i == chats.length - 1 ||
                                        i == chatController.clikedMessageNumber
                                    ? Center(
                                        child: CustomText(
                                          txt: DateFormat('h:mm a')
                                              .format(messageTime.toDate()),
                                        ),
                                      )
                                    : Padding(padding: EdgeInsets.zero),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () =>
                                      chatController.getClickedMessageNumber(i),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      minWidth: 40,
                                      maxWidth: size.width * 0.5,
                                    ),
                                    child: Card(
                                      color:
                                          chats[i]['from'] != shippingCompany.id
                                              ? Colors.blue
                                              : Colors.black38,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomRight: chats[i]['from'] !=
                                                      shippingCompany.id
                                                  ? Radius.circular(15)
                                                  : Radius.zero,
                                              bottomLeft: chats[i]['from'] ==
                                                      shippingCompany.id
                                                  ? Radius.circular(15)
                                                  : Radius.zero)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomText(
                                          txt: chats[i]['message'],
                                          maxLine: 20,
                                          txtColor: Colors.white,
                                          fSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, i) =>
                              SizedBox(height: 10),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextFormField(
                        controller: _messageController,
                        onChanged: (val) => chatController.getMessage(val),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 14),
                          hintText: 'Type your message...',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              onTap: null,
                              child: Image.asset(
                                'assets/other/add.png',
                              ),
                            ),
                          ),
                          suffixIcon: InkWell(
                            onTap: chatController.message == null
                                ? null
                                : () {
                                    Get.find<ChatViewModel>().uploadChat(
                                        createdAt: Timestamp.now(),
                                        from: customer.id,
                                        to: shippingCompany.id,
                                        message: chatController.message,
                                        orderNumber: orderNumber);
                                    _messageController.clear();
                                  },
                            child: Image.asset('assets/other/send.png'),
                          ),
                        )),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
