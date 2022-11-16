import 'package:data_app/domain/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productHttpRepository = Provider<ProductHttpRepository>((ref) {
  return ProductHttpRepository();
});
// 싱글톤으로 관리하려고(메모리에 띄워줌)

// spring repository - db에 연결
// flutter repository - spring controller에 연결/ spring server repository가 참조하는건 resource 서버
// 자기 db가 아니라 외부 서버에 연결하는거(외부에 통신하는 repository) - http/ 내부저장소는 local repository
class ProductHttpRepository {
  List<Product> list = [
    Product(1, "바나나", 1000),
    Product(2, "딸기", 2000),
    Product(3, "참외", 3000)
  ];
  // 실제로는 spring에서 데이터 받아와야함!

  Product findById(int id) {
    // 빈상자를 리턴 - 통신되는동안 cpu가 먼저 빈상자를 리턴
    // http 통신 코드
    // 메서드 때리면 cpu가 ram에 요청하고 메모리가 통신하는 동안 밑의 코드 실행 통신시작하고 리턴되는건 dto(entity)
    // 단일 스레드여서 통신되는 동안 기다려야 되는데 그럼 cpu가 클라이언트의 요청을 실행할 수 없으니까 먼저 빈상자를 return 함
    // watch 하고 있다가 future 박스에 데이터 들어오면 rebuild

    // 통신하고 데이터 받으면 json 으로 파싱해서 리턴

    Product product = list.singleWhere((product) => product.id == id);
    return product;
  }

  List<Product> findAll() {
    // http 통신 코드
    return list;
  }

  Product insert(Product product) {
    // http 통신 코드
    // 받은 값(product)을 기존 리스트에 추가
    product.id = 4;
    list = [...list, product];
    return product;
  }

  Product updateById(int id, Product productDto) {
    // http 통신 코드
    list = list.map((product) {
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
    list = list.where((product) => product.id != id).toList();
    // product.id 와 같지 않은 id만 리턴해줌
    if (id == 4) {
      return -1;
    } else {
      return 1;
    }
  }
}
