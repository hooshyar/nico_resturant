class NicoItem {
  final num price;
  final String name;
  final String image;
  final String id;
  final String type;
  final double stars;
  final int quantity;

  const NicoItem({
    this.id,
    this.stars,
    this.type,
    this.image,
    this.name,
    this.price,
    this.quantity: 0,
  }) : assert(quantity != null && quantity >= 0);

  NicoItem copyWith(
      {String id,
      String image,
      String name,
      num price,
      int quantity,
      double stars,
      String type}) {
    return new NicoItem(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        price: price ?? this.price,
        type: type ?? this.type,
        stars: stars ?? this.stars,
        quantity: quantity ?? this.quantity);
  }
}
