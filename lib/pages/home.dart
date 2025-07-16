import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/product_card.dart';
import 'package:shopping_app/pages/details_page.dart';

import '../widgets/global_variables.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void applyFilters() {
    String input = _textEditingController.text.trim().toLowerCase();

    filteredList = products.where((product) {
      final title = product['title']?.toString().toLowerCase() ?? '';

      final matchesSearch = input.isEmpty || title.contains(input);
      final matchesFilter =
          selectedFilter.toLowerCase() == 'all' ||
          title.contains(selectedFilter.toLowerCase());

      return matchesSearch && matchesFilter;
    }).toList();
  }

  final List<String> filters = ['All', "M&M's", 'Godiva', "Hershey's"];
  late String selectedFilter;
  List filteredList = List.from(products);
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Chocolate \nCollection',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: TextField(
                    autofocus: false,
                    controller: _textEditingController,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                        ),
                      ),
                      prefixIcon: GestureDetector(
                        onTap: () {
                          String input = _textEditingController.text
                              .trim()
                              .toLowerCase();

                          applyFilters();

                          FocusScope.of(context).unfocus(); // dismiss keyboard
                          setState(() {}); // refresh UI
                        },
                        child: Icon(Icons.search, size: 22),
                      ),
                      hintText: 'Search',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filters[index];

                        applyFilters();
                      });

                      debugPrint(selectedFilter);
                    },
                    child: Chip(
                      label: Text(
                        filters[index],
                        style: TextStyle(color: Colors.black),
                        // Button-like text
                      ),
                      labelStyle: TextStyle(fontSize: 15),
                      backgroundColor: selectedFilter != filters[index]
                          ? const Color.fromARGB(134, 186, 176, 176)
                          : Color.fromARGB(
                              255,
                              219,
                              116,
                              26,
                            ), // Light grey background
                      shape: StadiumBorder(), // Pill/capsule shape
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,

              itemBuilder: (context, index) {
                final product = filteredList[index];
                debugPrint('${products.length}'); //return Text(product'title');
                return GestureDetector(
                  onTap: () async {
                    if (FocusScope.of(context).hasFocus) {
                      FocusScope.of(
                        context,
                      ).unfocus(); // First, close the keyboard
                      await Future.delayed(
                        Duration(milliseconds: 150),
                      ); // Then wait 150ms
                    }
                    if (context.mounted) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Details(product: product);
                          },
                        ),
                      );
                    }
                  },
                  child: ProductCard(
                    index: product['id'],
                    title: product['title'],
                    img: product['img'],
                    price: product['price'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
