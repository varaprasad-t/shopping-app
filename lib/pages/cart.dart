import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/widgets/global_variables.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    print(Provider.of<CartProvider>(context).cart);
    double totalPrice = cart.fold(0.0, (sum, item) {
      final map = item as Map<String, dynamic>;
      return sum + (map['price'] ?? 0.0);
    });
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: cart.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      debugPrint('CART IMAGE PATH: ${cart[index]['img']}');
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[300],
                          child: ClipOval(
                            child: Image.asset(
                              cart[index]['img'].toString(),
                              fit: BoxFit.fill,

                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.image_not_supported),
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Center(
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 169, 78, 35),
                                      ),
                                    ),
                                  ),
                                  content: Text(
                                    'Are you sure you want to delete this product?',
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        MenuItemButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'NO',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                255,
                                                179,
                                                91,
                                                28,
                                              ),
                                            ),
                                          ),
                                        ),

                                        MenuItemButton(
                                          onPressed: () {
                                            Provider.of<CartProvider>(
                                              context,
                                              listen: false,
                                            ).removeProduct(cart[index]);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                              color: Color(0xFFB47B52),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                        title: Center(
                          child: Text(cart[index]['title'] as String),
                        ),
                        subtitle: Center(
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                'Total : \₹${cart[index]['price'].toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text('qty : ${cart[index]['qty']}'),
                              Spacer(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                cart.isNotEmpty
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return Scaffold(
                                  appBar: AppBar(
                                    title: Text('Checkout Page'),
                                    leading: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(Icons.arrow_back, size: 30),
                                    ),
                                  ),
                                  body: Center(
                                    child: Text(
                                      'Coming soon......',
                                      style: TextStyle(fontSize: 40),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Spacer(),
                            Text(
                              cart.isNotEmpty
                                  ? 'Total: \₹${totalPrice.toStringAsFixed(2)}'
                                  : '',
                              style: TextStyle(fontSize: 18),
                            ),
                            Spacer(),
                            Text('checkout'),
                            Icon(Icons.arrow_right, size: 30),
                          ],
                        ),
                      )
                    : Text(''),
              ],
            )
          : Center(
              child: Text('Add something.....', style: TextStyle(fontSize: 35)),
            ),
    );
  }
}
