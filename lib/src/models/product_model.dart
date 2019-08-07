class Product {
  final int productID;
  final int productLastFee;
  final String productName;
  final String productRegDate;

  Product(
      {this.productID,
      this.productLastFee,
      this.productName,
      this.productRegDate});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productID: json['productID'] ?? 0,
      productLastFee: json['productLastFee'] ?? 0,
      productName: json['productName'] ?? 'fgd',
      productRegDate: json['productRegDate'] ?? 'f',
    );
  }
}
