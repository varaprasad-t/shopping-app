import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart_provider.dart';

class Details extends StatefulWidget {
  final Map<String, Object> product;

  const Details({super.key, required this.product});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  double selected = 1;
  late double price;
  late double unitPrice;
  @override
  void initState() {
    super.initState();
    unitPrice = double.parse(widget.product['price'].toString());
    price = unitPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment(-0.19, 3),
          child: Text('Details', style: TextStyle(fontSize: 20)),
        ),
        leading: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios_outlined),
        ),
      ),
      body: Column(
        children: [
          Spacer(flex: 1),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                widget.product['title'].toString(),
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 450,
            //padding: const EdgeInsets.all(0),
            child: Image.asset(widget.product['img'].toString()),
          ),

          Text('\₹${price.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    if (selected > 1) selected--;
                    price = selected * unitPrice;
                  });
                },
              ),
              Text(selected.toInt().toString(), style: TextStyle(fontSize: 20)),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  debugPrint('Trying to load: ${widget.product['img']}');
                  setState(() {
                    selected++;
                    price = selected * unitPrice;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
              style: ButtonStyle(),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).addProduct({
                  'id': widget.product['id'],
                  'img': widget.product['img'],
                  'price': price,
                  'title': widget.product['title'],
                  'qty': selected.toInt(),
                });
                debugPrint(price.toString());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('successfully added!'),
                    duration: Duration(milliseconds: 50),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.shopping_cart), Text('Add to cart')],
              ),
            ),
          ),
          Spacer(flex: 5),
        ],
      ),
    );
  }
}
