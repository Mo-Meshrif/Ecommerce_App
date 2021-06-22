import 'package:flutter/material.dart';
import 'customStackIcon.dart';

class MessagesNotBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => null,
          child: CustomStackIcon(
            imageUrl: 'assets/home/Messages.png',
            txtNum: '5',
          ),
        ),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () => null,
          child: CustomStackIcon(
            imageUrl: 'assets/home/notifications.png',
            txtNum: '10',
          ),
        ),
      ],
    );
  }
}