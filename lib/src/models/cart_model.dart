class CartItem {
  final String itemId;
  final String itemImage;
  final num foodPrice;
  final String foodName;
  final int itemQTY;

  CartItem(
      {this.itemId,
      this.itemImage,
      this.foodPrice,
      this.foodName,
      this.itemQTY});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      itemId: json['itemId'] ?? '0',
      itemImage: json['itemImage'] ?? '0',
      foodPrice: json['foodPrice'] ?? 0,
      foodName: json['foodName'] ?? 'fgd',
      itemQTY: json['itemQTY'] ?? 0,
    );
  }
}

class Cart {
  final List<CartItem> itemNames;
  final String cartID; // TableNum + CartIndex
  final num totalPrice;
  final int itemQTY;
  final String sit; // open ,order , served , paid , closed

  Cart(this.cartID, this.itemNames, this.itemQTY, this.sit, this.totalPrice);
}
