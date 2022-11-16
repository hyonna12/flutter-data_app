// view model의 데이터를 provider로
// page에 필요한 데이터 관리
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewModel =
    StateNotifierProvider<ProductListViewModel, List<Product>>((ref) {
  return ProductListViewModel(ref.read(productHttpRepository).findAll());
});

class ProductListViewModel extends StateNotifier<List<Product>> {
  ProductListViewModel(super.state);

  void onRefresh(List<Product> products) {
    state = products;
  }
}
