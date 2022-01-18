import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_shopping/BranchesPage.dart';
import 'package:test_shopping/DescriptionPage.dart';
import 'package:test_shopping/LoginPage.dart';
import 'package:test_shopping/ShopBottomNavigation.dart';
import 'package:http/http.dart';
import 'package:test_shopping/ShoppingBascket.dart';
import 'package:test_shopping/product.dart';

class MainMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class Store extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Store> {
  List<Product> _Item = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        title: Text('Store',
            style: TextStyle(fontSize: 25.0, color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.list,
            size: 30.0,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_basket,
            ),
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondanimation) {
                    return ShoppingBascket();
                  },
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondanimation,
                      Widget child) {
                    return SlideTransition(
                      child: child,
                      position:
                          Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                              .animate(CurvedAnimation(
                                  parent: animation, curve: Curves.linear)),
                    );
                  }));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.map,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BranchesPage()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 10.0,
          crossAxisCount: 2,
          children: List.generate(_Item.length, (int position) {
            return generateItem(_Item[position], context);
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.amber[400],
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ShopBottomNavigation(),
    );
  }

  void fetchItem() async {
    var url = "http://welearnacademy.ir/flutter/products_list.json";
    Response response = await get(url);
    setState(() {
      var productJson = json.decode(utf8.decode(response.bodyBytes));
      for (var i in productJson) {
        var productItem = Product(i['product_name'], i['id'], i['price'],
            i['image_url'], i['off'], i['description']);
        _Item.add(productItem);
      }
    });
  }
}

Card generateItem(Product product, BuildContext context) {
  return Card(
    elevation: 6.0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0))),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DescriptionPage(product),
        ));
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 100,
                height: 100,
                child: Image.network(product.imageurl)),
            Text(product.price),
            Text(product.productName),
          ],
        ),
      ),
    ),
  );
}
