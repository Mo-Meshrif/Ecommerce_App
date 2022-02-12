import 'package:flutter/material.dart';
import 'customText.dart';

class MoreCardBuilder extends StatelessWidget {
  final List<Map<String, dynamic>> components;

  MoreCardBuilder({required this.components});

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
        itemCount: components.length,
        itemBuilder: (context, i) => GestureDetector(
          onTap: components[i]['onTap'],
          child: ListTile(
            leading: Image.asset(components[i]['icon']),
            title: CustomText(
              txt: components[i]['txt'],
            ),
            trailing: Image.asset('assets/home/right_arrow_c.png'),
          ),
        ),
      ),
    );
  }
}
