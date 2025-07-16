import 'package:flutter/material.dart';
import 'package:shopping_app/pages/cart.dart';

import 'package:shopping_app/pages/home.dart';

class ShoppingApp extends StatefulWidget {
  //final title;

  const ShoppingApp({super.key});

  @override
  State<ShoppingApp> createState() => _ShoppingAppState();
}

class _ShoppingAppState extends State<ShoppingApp> {
  int currentpage = 0;
  List<Widget> pages = [Home(), Cart()];
  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 0,
          unselectedFontSize: 0,
          backgroundColor: Color(0xFFFFF8E1),
          iconSize: 30,
          currentIndex: currentpage,
          onTap: (value) {
            setState(() {
              currentpage = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: IndexedStack(index: currentpage, children: pages),
      ),
    );
  }
}
