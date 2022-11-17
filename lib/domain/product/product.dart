class Product {
  Product({required this.id, required this.name, required this.price});

  int id;
  String name;
  int price;
  // {}는 받을수도 안받을수도 있어서 null 허용한다고 ? 붙여줌
  // 변수 앞에 _ 붙이면 private

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}
