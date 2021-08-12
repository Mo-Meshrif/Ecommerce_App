import 'package:flutter/material.dart';
import 'customText.dart';

class CustomPopUpMenuButton extends StatelessWidget {
  final String title;
  final List<String> popList;
  final Function(String) onSelected;
  final bool enabled;

  const CustomPopUpMenuButton(
      {@required this.title,
      @required this.popList,
      @required this.onSelected,
      @required this.enabled});
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      enabled: enabled,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            CustomText(
              txt: title,
              fSize: 17,
            ),
            SizedBox(
              width: 5,
            ),
            Icon(Icons.more_vert)
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => popList
          .map((e) => PopupMenuItem(
              value: e,
              child: CustomText(
                txt: e,
              )))
          .toList(),
      onSelected: onSelected,
    );
  }
}
