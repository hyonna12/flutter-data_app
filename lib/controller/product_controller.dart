// VIEW -> Controller
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:data_app/views/product/list/product_list_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productController = Provider<ProductController>((ref) {
  return ProductController(ref);
});
//( 싱글톤으로 관리@Controller)

class ProductController {
  final Ref _ref;
  ProductController(this._ref);

  void findAll() {
    List<Product> productList = _ref.read(productHttpRepository).findAll();
    _ref.read(productListViewModel.notifier).onRefresh(productList);
  }
}
