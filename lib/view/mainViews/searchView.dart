import '../../const.dart';
import '../../view/widgets/customRTxtGTxt.dart';
import '../../view/widgets/customText.dart';
import '../../view/widgets/messagesNotBar.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MessagesNotBar(),
          SizedBox(height: 15),
          CustomText(
            txt: 'Search',
            txtColor: swatchColor,
            fSize: 30,
            fWeight: FontWeight.bold,
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              onChanged: (val) => null,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                hintText: 'Search Something',
              ),
            ),
          ),
          SizedBox(height: 20),
          CustomRTxtGTxt(
            txt1: 'RECENTLY VIEWED',
            txt2: 'CLEAR',
            onT: () => null,
          ),
          SizedBox(height: 15),
          Container(
            height: 80,
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) => Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/home/backpack.png',
                        height: 40,
                        width: 40,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            txt: 'Bottle Green Backpack',
                          ),
                          CustomText(
                            txt: '\$20.58',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          CustomRTxtGTxt(
            txt1: 'RECOMMENDED',
            txt2: 'REFRESH',
            onT: () => null,
          ),
          SizedBox(height: 15),
          LimitedBox(
            maxHeight: 100,
            child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 50,
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, x) => Card(
                      child: Center(
                        child: CustomText(
                          txt: 'Denim Jeans',
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
