class Product {
  int id;
  String name;
  int price;
  // {}는 받을수도 안받을수도 있어서 null 허용한다고 ? 붙여줌
  // 변수 앞에 _ 붙이면 private
  Product(this.id, this.name, this.price);
  // 통신할땐 dto사용
}
