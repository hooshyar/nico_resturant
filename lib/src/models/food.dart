class NicoFood {
  final String price;
  final String name;
  final String image;
  final String id;
  final int quantity;

  const NicoFood({
    this.id,
    this.image,
    this.name,
    this.price,
    this.quantity: 0,
  }) : assert(quantity != null && quantity >= 0);

  NicoFood copyWith(
      {String id, String image, String name, String price, int quantity}) {
    return new NicoFood(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity);
  }
}
