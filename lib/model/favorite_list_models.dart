// @dart=2.9
import 'package:detective_pikachu/model/place.dart';
class Item {
  final int id;
  final String name;
  final String subtitle;

  Item(this.id, this.name, this.subtitle);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;


}

class FavoriteListModel {
  List<String> itemNames = [
    // 7
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
  ];

  List<String> itemSubtitle = [
    'A의 주소',
    'B의 주소',
    'c의 주소',
    'd의 주소',
    'e의 주소',
    'f의 주소',
    'g의 주소',

  ];

  Item getById(int id) => Item(
    id,
    itemNames[id % itemNames.length],
    itemSubtitle[id % itemSubtitle.length],
  );

  Item getByPosition(int position) {
    return getById(position);
  }

}