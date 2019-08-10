import 'package:nico_resturant/src/models/food.dart';

class Menu {
  static List<NicoItem> menu = [
    NicoItem(
        id: "1",
        image: "lib/assets/images/menu1.png",
        name: "LASAGNE",
        price: 12,
        stars: 4,
        type: 'food'),
    NicoItem(
        id: "3",
        image: "lib/assets/images/menu11.png",
        name: "MUSHROOM RISOTTO",
        price: 4,
        stars: 4,
        type: 'food'),
    NicoItem(
        id: "4",
        image: "lib/assets/images/menu13.png",
        name: "CIOPPINO",
        price: 30,
        stars: 4,
        type: 'food'),
    NicoItem(
        id: "5",
        image: "lib/assets/images/menu12.png",
        name: "SEAFOOD PLATTER",
        price: 22,
        stars: 4,
        type: 'food'),
    NicoItem(
        id: "2",
        image: "lib/assets/images/menu3.png",
        name: "TORTELLINI WITH BROCCOLI",
        price: 8,
        stars: 4,
        type: 'food'),
    NicoItem(
        id: "6",
        image: "lib/assets/images/menu10.png",
        name: "MEAT ROLL",
        price: 19,
        stars: 4,
        type: 'food'),
    NicoItem(
        id: "7",
        image: "lib/assets/images/menu7.png",
        name: "SALMON SALAD",
        price: 25,
        stars: 4,
        type: 'food'),
    NicoItem(
        id: "8",
        image: "lib/assets/images/menu5.png",
        name: "MEATBALLS AND PASTA",
        price: 7,
        stars: 4,
        type: 'food'),
    NicoItem(
        id: "9",
        image: "lib/assets/images/menu9.png",
        name: "STEAK AU POIVRE",
        price: 63,
        stars: 4,
        type: 'food'),
    NicoItem(
        id: "10",
        image: "lib/assets/images/menu8.png",
        name: "CHICKEN SALAD",
        price: 43,
        stars: 4,
        type: 'food'),
    NicoItem(
        id: "11",
        image: "lib/assets/drinks/water.png",
        name: "WATER",
        price: 1,
        stars: 5,
        type: 'drink'),
    NicoItem(
        id: "12",
        image: "lib/assets/drinks/mojito.png",
        name: "MOJITO",
        price: 5,
        stars: 4,
        type: 'drink'),
    NicoItem(
        id: "12",
        image: "lib/assets/drinks/wine-s.png",
        name: "FRENCH WINE",
        price: 65,
        stars: 4,
        type: 'drink'),
  ];

  static NicoItem getNicoItemById(id) {
    return menu.where((p) => p.id == id).first;
  }
}
