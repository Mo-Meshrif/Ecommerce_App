import 'package:flutter/material.dart';
import 'customText.dart';

class MoreCardBuilder extends StatelessWidget {
  final int initialIndex;
  final List<Map<String, dynamic>> components;

  MoreCardBuilder({@required this.initialIndex, @required this.components});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListView.separated(
        separatorBuilder: (context, i) => Divider(
          thickness: 1,
          indent: 70,
          height: 5,
          color: Colors.grey[300],
        ),
        padding: EdgeInsets.zero,
        itemCount: 3,
        itemBuilder: (context, i) => GestureDetector(
          onTap: components[i + initialIndex]['onTap'],
          child: ListTile(
            leading: Image.asset(components[i + initialIndex]['icon']),
            title: CustomText(
              txt: components[i + initialIndex]['txt'],
            ),
            trailing: Image.asset('assets/home/right_arrow_c.png'),
          ),
        ),
      ),
    );
  }
}
