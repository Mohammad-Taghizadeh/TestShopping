import 'package:flutter/material.dart';
import 'package:test_shopping/product.dart';

typedef OnRemovePressed(int index);

class ShoppingBascketItem extends StatefulWidget {
  Product _product;
  int count = 0;
  int _index;
  OnRemovePressed _onRemovePressed;
  ShoppingBascketItem(this._product, this._index, this._onRemovePressed);
  @override
  _ShoppingBascketItemState createState() => _ShoppingBascketItemState();
}

class _ShoppingBascketItemState extends State<ShoppingBascketItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Container(
        height: 150,
        child: Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Image.network(widget._product.imageurl)),
            Padding(
              padding: EdgeInsets.only(right: 30.0, top: 10.0),
              child: Column(
                children: [
                  Text(
                    widget._product.productName,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 65.0,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.chevron_left,
                          size: 30,
                        ),
                        onTap: () {
                          Increment();
                        },
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(widget.count.toString()),
                      SizedBox(
                        width: 5.0,
                      ),
                      GestureDetector(
                        child: Icon(Icons.chevron_right, size: 30.0,),
                        onTap: () {
                          Decrement();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 15.0, top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Icon(Icons.delete_forever),
                        onTap: () {
                          widget._onRemovePressed(widget._index);
                        },
                      ),
                      Text(
                        widget._product.price,
                        style: TextStyle(color: Colors.redAccent[700]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void Increment() {
    setState(() {
      return widget.count++;
    });
  }

  void Decrement() {
    setState(() {
      if (widget.count == 0)
        return;
      else {
        widget.count--;
      }
    });
  }
}
