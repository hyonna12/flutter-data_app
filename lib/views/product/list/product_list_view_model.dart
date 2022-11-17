// view model의 데이터를 provider로
// page에 필요한 데이터 관리
import 'package:data_app/controller/product_controller.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewModel =
    StateNotifierProvider<ProductListViewModel, List<Product>>((ref) {
  return ProductListViewModel([], ref)..initViewModel();
});

class ProductListViewModel extends StateNotifier<List<Product>> {
  Ref _ref;
  ProductListViewModel(super.state, this._ref);

  Future<void> initViewModel() async {
    print("실행됨");
    state = await _ref.read(productHttpRepository).findAll();
  }

  void refresh(List<Product> productsDto) {
    state = productsDto;
  }

  void addProduct(Product productRespDto) {
    state = [...state, productRespDto];
  }
  // vs가 가지고 있는 state 갱신
  // state는 최초에 new 될때 만들어짐

  void removeProduct(int id) {
    state = state.where((product) => product.id != id).toList();
  }

  void updateProduct(Product productRespDto) {
    state = state.map((product) {
      if (product.id == productRespDto.id) {
        return productRespDto;
      } else {
        return product;
      }
    }).toList();
  }
}
