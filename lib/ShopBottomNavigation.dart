import 'package:flutter/material.dart';

class ShopBottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 7.0,
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 55,
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width / 2 - 30,
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.home,color: Colors.grey),
                  Icon(Icons.person,color: Colors.grey),
                ],
              ),
            ),
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width / 2 - 30,
            
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.search,color: Colors.grey),
                  Icon(Icons.favorite,color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
