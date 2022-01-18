import 'package:test_shopping/ShoppingBascket.dart';
import 'package:test_shopping/product.dart';

class ShoppingBascketData {
  static ShoppingBascketData _instance;
  List<Product> _bascketItem;

  ShoppingBascketData() {
    _bascketItem = List<Product>();
  }

 List<Product> get bascketItem => _bascketItem;
  
  set bascketItem(List<Product> value){
    _bascketItem = value;
  }

  static ShoppingBascketData getinstance(){
    if(_instance==null){
      _instance= ShoppingBascketData();
    }
    return _instance;
  }
}
