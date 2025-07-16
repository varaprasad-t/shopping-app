import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final title;
  final img;
  final price;
  final index;
  const ProductCard({
    super.key,
    required this.title,
    required this.img,
    required this.price,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: double.parse(index) % 2 == 0
              ? const Color.fromARGB(124, 230, 177, 121)
              : const Color.fromARGB(255, 230, 177, 121),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(img, height: 150, fit: BoxFit.contain)),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '\₹${price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}
