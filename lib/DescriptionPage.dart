import 'package:flutter/material.dart';
import 'package:myapp/ShoppingBascketData.dart';
import 'package:myapp/StoreMainMenuPage.dart';
import 'product.dart';

class DescriptionPage extends StatefulWidget {
  Product _product;
  DescriptionPage(this._product);
  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        title: Text('Store',
            style: TextStyle(fontSize: 25.0, color: Colors.white)),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Store()));
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(children: [
        Align(
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Text(
              'Shoes',
              style: TextStyle(fontSize: 40.0, color: Colors.grey[400]),
            ),
          ),
          alignment: Alignment.topLeft,
        ),
        Center(
          child: Container(
            height: 260,
            width: 260,
            child: Image.network(widget._product.imageurl),
          ),
        ),
        Text(
          widget._product.price,
          style: TextStyle(fontSize: 30.0, color: Colors.red[900]),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          widget._product.productName,
          style: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
        ),
        SizedBox(
          height: 15.0,
        ),
        Padding(
          padding: EdgeInsets.only(left: 45.0, right: 45.0),
          child: Text(
            widget._product.description,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Align(
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.amber[600],
                child: GestureDetector(
                  onTap: (){
                    ShoppingBascketData.getinstance().bascketItem.add(widget._product);
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 60,
                    child: Center(
                      child: Text(
                        'Add  To  Bascket',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
      ]),
    );
  }
}
