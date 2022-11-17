import 'dart:convert';

import 'package:data_app/domain/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import '../http_connector.dart';

final productHttpRepository = Provider<ProductHttpRepository>((ref) {
  return ProductHttpRepository(ref);
});
// 싱글톤으로 관리하려고(메모리에 띄워줌)

// spring repository - db에 연결
// flutter repository - spring controller에 연결/ spring server repository가 참조하는건 resource 서버
// 자기 db가 아니라 외부 서버에 연결하는거(외부에 통신하는 repository) - http/ 내부저장소는 local repository
class ProductHttpRepository {
  Ref _ref;
  ProductHttpRepository(this._ref);

  Future<Product> findById(int id) async {
    // 빈상자를 리턴 - 통신되는동안 cpu가 먼저 빈상자를 리턴
    // http 통신 코드
    // 메서드 때리면 cpu가 ram에 요청하고 메모리가 통신하는 동안 밑의 코드 실행 통신시작하고 리턴되는건 dto(entity)
    // 단일 스레드여서 통신되는 동안 기다려야 되는데 그럼 cpu가 클라이언트의 요청을 실행할 수 없으니까 먼저 빈상자를 return 함
    // watch 하고 있다가 future 박스에 데이터 들어오면 rebuild

    // 통신하고 데이터 받으면 json 으로 파싱해서 리턴

    Response response =
        await _ref.read(httpConnector).get("/api/product/${id}");
    Product product = Product.fromJson(jsonDecode(response.body));
    return product;
  }

  Future<List<Product>> findAll() async {
    Response response = await _ref.read(httpConnector).get("/api/product");
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)["data"];
      List<Product> productList = body.map((e) => Product.fromJson(e)).toList();
      return productList;
    } else {
      return [];
    }
  }

  Product insert(Product product) {
    // http 통신 코드
    // 받은 값(product)을 기존 리스트에 추가
    product.id = 4;

    return product;
  }

  Product updateById(int id, Product productDto) {
    // http 통신 코드
    final list = [].map((product) {
      if (product.id == id) {
        product = productDto;
        return product;
      } else {
        return product;
      }
    }).toList();
    productDto.id = id;
    return productDto;
  }

  int deleteById(int id) {
    // http 통신 코드
    final list = [].where((product) => product.id != id).toList();
    // product.id 와 같지 않은 id만 리턴해줌
    if (id == 4) {
      return -1;
    } else {
      return 1;
    }
  }
}
