import 'package:flutter/material.dart';
import '../../const.dart';
import 'customText.dart';

class Reviews extends StatelessWidget {
  final String? name, date, reviewDetails;
  final double rateValue;
  Reviews(
      {required this.name,
      required this.date,
      required this.reviewDetails,
      required this.rateValue});
  @override
  Widget build(BuildContext context) {
    String getInitials(String name) => name.isNotEmpty
        ? name.trim().split(' ').map((l) => l[0]).take(2).join()
        : '';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 35,
          child: CustomText(
            txt: getInitials(name!),
            fSize: 22,
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    height: 30,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, x) => Icon(
                        Icons.star,
                        size: 20,
                        color: x + 1 <= rateValue ? priColor : Colors.grey[300],
                      ),
                    ),
                  ),
                  CustomText(
                    txt: date,
                  ),
                ],
              ),
              CustomText(
                txt: name,
                fWeight: FontWeight.w500,
                fSize: 17,
                txtColor: swatchColor,
              ),
              CustomText(
                txt: reviewDetails,
                txtColor: swatchColor,
                maxLine: 3,
              ),
            ],
          ),
        )
      ],
    );
  }
}
