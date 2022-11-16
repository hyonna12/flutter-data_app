// view model의 데이터를 provider로
// page에 필요한 데이터 관리
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewStore =
    StateNotifierProvider<ProductListViewStore, List<Product>>((ref) {
  return ProductListViewStore(ref.read(productHttpRepository).findAll());
});

class ProductListViewStore extends StateNotifier<List<Product>> {
  ProductListViewStore(super.state);

  void onRefresh(List<Product> products) {
    state = products;
  }
}
