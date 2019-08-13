import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  Food(this.foodName, this.reference, this.foodId, this.rate, this.foodPrice,
      this.isServe, this.imageUrl, this.selected);

  String foodName;
  String imageUrl;
  String tag;
  num foodPrice;
  num foodId;
  num rate;
  bool isServe;
  final DocumentReference reference;

  Food.fromMap(Map<String, dynamic> map, {this.reference})
      : foodName = map['foodName'] ?? 'default',
        foodId = map['foodId'] ?? 0,
        foodPrice = map['foodPrice'] ?? 0,
        rate = map['rate'] ?? 0,
        isServe = map['isServe'] ?? true,
        tag = map['tag'] ?? 'general',
        imageUrl = map['imageUrl'];

  Food.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  bool selected = false;
}

class Drink {
  Drink(this.drinkName, this.reference, this.drinkId, this.drinkPrice,
      this.rate, this.isServe, this.selected, this.imageUrl, this.tag);

  String drinkName;
  String imageUrl;
  num drinkPrice;
  num drinkId;
  num rate;
  String tag;
  bool isServe;
  final DocumentReference reference;

  Drink.fromMap(Map<String, dynamic> map, {this.reference})
      : drinkName = map['drinkName'] ?? 'default',
        drinkId = map['drinkId'] ?? 0,
        tag = map['tag'] ?? 'general',
        drinkPrice = map['drinkPrice'] ?? 0,
        rate = map['rate'] ?? 0,
        isServe = map['isServe'] ?? true,
        imageUrl = map['imageUrl'];

  Drink.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  bool selected = false;
}
