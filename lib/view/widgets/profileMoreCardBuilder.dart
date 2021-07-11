import 'package:flutter/material.dart';
import 'customText.dart';

class ProfileMoreCardBuilder extends StatelessWidget {
  final int initialIndex;
  final List<Map<String, String>> components;

  ProfileMoreCardBuilder(
      {@required this.initialIndex, @required this.components});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListView.separated(
        separatorBuilder: (context, i) => Divider(
          indent: 70,
          height: 5,
          color: Colors.grey[300],
        ),
        padding: EdgeInsets.zero,
        itemCount: 4,
        itemBuilder: (context, i) => ListTile(
          leading: Image.asset(components[i + initialIndex]['icon']),
          title: CustomText(
            txt: components[i + initialIndex]['txt'],
          ),
          trailing: Image.asset('assets/home/right_arrow_c.png'),
        ),
      ),
    );
  }
}
