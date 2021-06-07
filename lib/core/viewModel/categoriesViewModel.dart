import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../const.dart';

class CategoriesViewModel extends GetxController {
  int currentCategory = 0;
  final List<Map<String, dynamic>> categories = [
    {
      'id': 0,
      'imgUrl': 'assets/home/apparel.png',
      'txt': 'Apparel',
      'avatarCol': priColor,
      'sub-cat': {
        's': [
          'MEN’S APPAREL',
          'WOMEN APPAREL',
        ],
        'c1': [
          'T-shirts',
          'Shirts',
          'Pants & Jeans',
          'Socks & Ties',
          'Underwear',
          'Jackets',
          'Coats',
          'Sweaters',
        ],
        'c2': [
          'Officewear',
          'Blouse & T-Shirts',
          'Pants & Jeans',
          'Dresses',
          'Lingerie',
          'Jackets',
          'Coats',
          'Sweaters',
        ],
      },
    },
    {
      'id': 1,
      'imgUrl': 'assets/home/beauty.png',
      'txt': 'Beauty',
      'avatarCol': HexColor('#76BAFF'),
      'sub-cat': {
        's': [],
        'c1': [],
        'c2': [],
      },
    },
    {
      'id': 2,
      'imgUrl': 'assets/home/shoes.png',
      'txt': 'Shoes',
      'avatarCol': HexColor('#2FC145'),
      'sub-cat': {
        's': [],
        'c1': [],
        'c2': [],
      },
    },
    {
      'id': 3,
      'imgUrl': 'assets/home/electronics.png',
      'txt': 'Electronics',
      'avatarCol': HexColor('#77A5F8'),
      'sub-cat': {
        's': [],
        'c1': [],
        'c2': [],
      },
    },
    {
      'id': 4,
      'imgUrl': 'assets/home/furniture.png',
      'txt': 'Furniture',
      'avatarCol': HexColor('#E6B15C'),
      'sub-cat': {
        's': [],
        'c1': [],
        'c2': [],
      },
    },
    {
      'id': 5,
      'imgUrl': 'assets/home/home.png',
      'txt': 'Home',
      'avatarCol': HexColor('#9F6EA3'),
      'sub-cat': {
        's': [],
        'c1': [],
        'c2': [],
      },
    },
    {
      'id': 6,
      'imgUrl': 'assets/home/stationary.png',
      'txt': 'Stationary',
      'avatarCol': HexColor('#505862'),
      'sub-cat': {
        's': [],
        'c1': [],
        'c2': [],
      },
    },
  ];

  changeCategories(index) {
    currentCategory = index;
    update();
  }
}
