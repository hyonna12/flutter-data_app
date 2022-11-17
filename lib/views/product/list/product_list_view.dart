import 'package:data_app/controller/product_controller.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/views/product/list/components/my_alert_dialog.dart';
import 'package:data_app/views/product/list/product_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListView extends ConsumerWidget {
  const ProductListView({Key? key}) : super(key: key);

  // view는 controller에 의존
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //product list page 가 build 될때 vm을 watch하고 있음
    final pm = ref.watch(productListViewModel); // 최초의 view 모델을 watch
    final pc = ref.read(productController);
    // pc.findAll(); // 바로 화면에 데이터가 뜨도록 - 데이터 들어오면 계속 rebuild

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          pc.findAll();
          // pc.insert(Product(4, "호박", 2000));
        },
      ),
      appBar: AppBar(title: Text("product_list_page")),
      body: ListView.builder(
        itemCount: pm.length,
        itemBuilder: (context, index) => ListTile(
          key: ValueKey(pm[index].id),
          onTap: () {
            //pc.deleteById(pm[index].id);
          },
          onLongPress: () {
            // pc.updateById();
          },
          leading: Icon(Icons.account_balance_wallet),
          title: Text(
            "${pm[index].name}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("${pm[index].price}"),
        ),
      ),
    );
  }
}
