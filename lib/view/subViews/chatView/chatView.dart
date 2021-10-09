import '../../../core/viewModel/moreViewModel.dart';
import '../../../core/viewModel/chatViewModel.dart';
import '../../../model/lastChatModel.dart';
import '../../../view/subViews/chatView/messageView.dart';
import '../../../view/widgets/customSearchBar.dart';
import '../../../view/widgets/customText.dart';
import '../../../const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _searchController = new TextEditingController();
    return Scaffold(
      body: GetBuilder<ChatViewModel>(
        builder: (chatController) {
          List<LastChatModel> lastchats =
              chatController.searchedCoversations.length > 0
                  ? chatController.searchedCoversations
                  : chatController.lastchats;
          String customerId = Get.find<MoreViewModel>().savedUser.id;
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
                lastchats.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text('No Message !'),
                        ),
                      )
                    : Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: CustomText(
                                txt: 'Messages',
                                fSize: 30,
                                fWeight: FontWeight.bold,
                                txtColor: swatchColor,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomSearchBar(
                              searchController: _searchController,
                              autoFocus: false,
                              onChanged: (val) => chatController
                                  .getSearchedCoversations(searchEntry: val),
                              onTap: null,
                              hintText: 'Search Coversations',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _searchController.text.isNotEmpty &&
                                    chatController.searchedCoversations.isEmpty
                                ? Padding(padding: EdgeInsets.zero)
                                : Expanded(
                                    child: ListView.separated(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 20),
                                      itemCount: lastchats.length,
                                      itemBuilder: (context, i) =>
                                          GestureDetector(
                                        onTap: () {
                                          chatController
                                              .updateChat(lastchats[i].id);
                                          Get.to(
                                            () => MessageView(
                                              customer: customerId ==
                                                      lastchats[i].to.id
                                                  ? lastchats[i].to
                                                  : lastchats[i].from,
                                              vendor: customerId ==
                                                      lastchats[i].to.id
                                                  ? lastchats[i].from
                                                  : lastchats[i].to,
                                              orderNumber:
                                                  lastchats[i].orderNumber,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          color: Colors.grey[50],
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                child: CustomText(
                                                  txt: joinFirstTwoLetter(
                                                      customerId ==
                                                              lastchats[i].to.id
                                                          ? lastchats[i]
                                                              .from
                                                              .userName
                                                          : lastchats[i]
                                                              .to
                                                              .userName),
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              Expanded(
                                                child: ListTile(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  title: CustomText(
                                                    txt: customerId ==
                                                            lastchats[i].to.id
                                                        ? lastchats[i]
                                                            .from
                                                            .userName
                                                            .capitalize
                                                        : lastchats[i]
                                                            .to
                                                            .userName
                                                            .camelCase,
                                                    fSize: 17,
                                                    fWeight: FontWeight.w500,
                                                  ),
                                                  subtitle: CustomText(
                                                    txt: lastchats[i]
                                                        .lastMessage,
                                                    fSize: 15,
                                                    fWeight: !lastchats[i]
                                                                .isOpened &&
                                                            customerId ==
                                                                lastchats[i]
                                                                    .to
                                                                    .id
                                                        ? FontWeight.w500
                                                        : FontWeight.w300,
                                                    maxLine: 2,
                                                  ),
                                                  trailing: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      CustomText(
                                                        txt: DateFormat(
                                                                'h:mm a')
                                                            .format(lastchats[i]
                                                                .messageTime
                                                                .toDate()),
                                                        txtColor: swatchColor,
                                                        fSize: 17,
                                                      ),
                                                      !lastchats[i].isOpened &&
                                                              customerId ==
                                                                  lastchats[i]
                                                                      .to
                                                                      .id
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 5),
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 8,
                                                                backgroundColor:
                                                                    priColor,
                                                              ),
                                                            )
                                                          : Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      separatorBuilder: (context, i) => Divider(
                                        color: Colors.grey,
                                        indent: size.width * 0.18,
                                        height: 20,
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
