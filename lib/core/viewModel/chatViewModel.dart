import '../../core/viewModel/moreViewModel.dart';
import '../../core/service/fireStore_chat.dart';
import '../../core/viewModel/authViewModel.dart';
import '../../model/lastChatModel.dart';
import '../../model/userModel.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatViewModel extends GetxController {
  List<LastChatModel> _lastchats = [];
  List<LastChatModel> get lastchats => _lastchats
      .where((element) =>
          (element.customerId == _moreViewModel.savedUser.id ||
              element.vendorId == _moreViewModel.savedUser.id) &&
          element.orderNumber != null)
      .toList();
  final AuthViewModel authViewModel = Get.find();
  final MoreViewModel _moreViewModel = Get.find();
  List<LastChatModel> searchedCoversations = [];
  int clikedMessageNumber;
  bool clickedMessageState = false;
  String message;
  onInit() {
    getLastChats();
    super.onInit();
  }

  getMessage(val) {
    message = val;
    update();
  }

  uploadChat(
      {@required Timestamp createdAt,
      @required String vendorId,
      @required String customerId,
      @required String from,
      @required String to,
      @required String message,
      @required int orderNumber}) {
    FireStoreChat()
        .addMessageToFireStore(
      createdAt: createdAt,
      vendorId: vendorId,
      customerId: customerId,
      from: from,
      to: to,
      message: message,
      orderNumber: orderNumber,
    )
        .then((value) {
      message = null;
      update();
      getLastChats();
    });
  }

  getLastChats() {
    FireStoreChat().getChatsFromFireStore().then((chats) {
      chats.forEach((chat) {
        Map data = chat.data();
        int index = _lastchats.indexWhere((element) =>
            element.vendorId == data['vendorId'] &&
            element.customerId == data['customerId']);
        UserModel sender = authViewModel.users
            .firstWhere((element) => element.id == data['to']);
        UserModel receiver = authViewModel.users
            .firstWhere((element) => element.id == data['from']);
        if (index >= 0) {
          _lastchats.removeAt(index);
          _lastchats.insert(
              0,
              LastChatModel(
                id: chat.id,
                messageTime: data['createdAt'],
                vendorId: data['vendorId'],
                customerId: data['customerId'],
                from: receiver,
                to: sender,
                lastMessage: data['message'],
                orderNumber: data['orderNumber'],
                isOpened: data['isOpened'],
              ));
        } else {
          _lastchats.insert(
              0,
              LastChatModel(
                id: chat.id,
                messageTime: data['createdAt'],
                vendorId: data['vendorId'],
                customerId: data['customerId'],
                from: receiver,
                to: sender,
                lastMessage: data['message'],
                orderNumber: data['orderNumber'],
                isOpened: data['isOpened'],
              ));
        }
      });
      update();
    });
  }

  updateChat(id) {
    FireStoreChat().updateIsOpenedParameter(id).then((_) => getLastChats());
  }

  getSearchedCoversations({@required String searchEntry}) {
    try {
      update();
      if (searchedCoversations.length > 0) {
        searchedCoversations = [];
        update();
      } else if (searchEntry == '') {
        return;
      }
      searchedCoversations = lastchats
          .where((chat) => _moreViewModel.savedUser.id == chat.from.id
              ? chat.to.userName.capitalizeFirst
                  .startsWith(searchEntry.capitalizeFirst)
              : chat.from.userName.capitalizeFirst
                  .startsWith(searchEntry.capitalizeFirst))
          .toList();
      update();
    } catch (e) {
      Get.snackbar('Alert', e);
    }
  }

  getClickedMessageNumber(val) {
    if (clikedMessageNumber == val) {
      clickedMessageState = !clickedMessageState;
    } else {
      clickedMessageState = true;
    }
    if (clickedMessageState) {
      clikedMessageNumber = val;
    } else {
      clikedMessageNumber = null;
    }
    update();
  }

  restClickedMessageNumber() {
    clikedMessageNumber = null;
    update();
  }
}
