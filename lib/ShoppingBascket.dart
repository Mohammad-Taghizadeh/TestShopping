import 'package:flutter/material.dart';
import 'package:myapp/ShoppingBascketData.dart';
import 'package:myapp/ShoppingBascketItem.dart';

import 'StoreMainMenuPage.dart';

class ShoppingBascket extends StatefulWidget {
  @override
  _ShoppingBascketState createState() => _ShoppingBascketState();
}

class _ShoppingBascketState extends State<ShoppingBascket> {
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
                .push(PageRouteBuilder(
                  transitionDuration: Duration(seconds:1),
                  pageBuilder: (BuildContext context, 
                  Animation<double> animation, 
                  Animation<double> secondanimation){
                    return Store();
                  },
                  transitionsBuilder: (BuildContext context,
                  Animation<double> animation, 
                  Animation<double> secondanimation, Widget child) {
                    return SlideTransition(
                      child: child,
                      position: Tween<Offset>(begin: Offset(1,0) ,end: Offset(0,0)).animate(CurvedAnimation(parent: animation,curve: Curves.linear)),
                  );}
                  ),

                );
                
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: BascketUI(),
    );
  }

  Widget BascketUI() {
    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(bottom: 65.0),
              child: ListView.builder(
          itemCount: ShoppingBascketData.getinstance().bascketItem.length,
          itemBuilder: (context, position) {
            return GestureDetector(
                child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: ShoppingBascketItem(
                  ShoppingBascketData.getinstance().bascketItem[position],
                  position,
                  RemoveItem),
            ));
          },
        ),
      ),
      Align(
            
            child: Container(
              color: Colors.amberAccent[700],
              height: 60,
              child: Center(
                child: Text('Pey', style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
      alignment: Alignment.bottomCenter,
      ),
    ]);
  }

  void RemoveItem(int index) {
    setState(() {
      ShoppingBascketData.getinstance().bascketItem.removeAt(index);
    });
  }
}
