import 'package:nico_resturant/src/models/food.dart';

class Menu {
  static List<NicoFood> menu = [
    NicoFood(
        id: "1",
        image: "lib/assets/images/menu1.png",
        name: "LASAGNE",
        price: "\$12"),
    NicoFood(
        id: "3",
        image: "lib/assets/images/menu11.png",
        name: "MUSHROOM RISOTTO",
        price: "\$4"),
    NicoFood(
        id: "4",
        image: "lib/assets/images/menu13.png",
        name: "CIOPPINO",
        price: "\$30"),
    NicoFood(
        id: "5",
        image: "lib/assets/images/menu12.png",
        name: "SEAFOOD PLATTER",
        price: "\$22"),
    NicoFood(
        id: "2",
        image: "lib/assets/images/menu3.png",
        name: "TORTELLINI WITH BROCCOLI",
        price: "\$8"),
    NicoFood(
        id: "6",
        image: "lib/assets/images/menu10.png",
        name: "MEAT ROLL",
        price: "\$19"),
    NicoFood(
        id: "7",
        image: "lib/assets/images/menu7.png",
        name: "SALMON SALAD",
        price: "\$25"),
    NicoFood(
        id: "8",
        image: "lib/assets/images/menu5.png",
        name: "MEATBALLS AND PASTA",
        price: "\$7"),
    NicoFood(
        id: "9",
        image: "lib/assets/images/menu9.png",
        name: "STEAK AU POIVRE",
        price: "\$63"),
    NicoFood(
        id: "10",
        image: "lib/assets/images/menu8.png",
        name: "CHICKEN SALAD",
        price: "\$43"),
  ];

  static NicoFood getNicoFoodById(id) {
    return menu.where((p) => p.id == id).first;
  }
}
