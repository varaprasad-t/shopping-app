import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/pages/splash.dart';
import 'package:shopping_app/providers/cart_provider.dart';

import 'package:shopping_app/widgets/shopping_app_frontscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return CartProvider();
      },

      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Quicksand',

          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6D4C41), // chocolate
            brightness: Brightness.light,
          ),

          scaffoldBackgroundColor: const Color(0xFFFFF8E1), // creamy background
          primaryColor: const Color(0xFF6D4C41), // rich chocolate
          hintColor: const Color(0xFFA1887F), // soft brown hint

          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFB47B52), // a richer caramel tone
            elevation: 3,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),

          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Color(0xFFFFF3E0), // soft cream
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xFF8D6E63),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide.none,
            ),
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD7A86E), // caramel
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              elevation: 2,
              shadowColor: Color(0xFFD7CCC8),
            ),
          ),

          cardTheme: const CardThemeData(
            color: Color(0xFFFFF3E0),
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            shadowColor: Color(0xFFD7CCC8),
          ),

          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: Color(0xFF4E342E),
            ),
            bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF3E2723)),
            labelLarge: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF6D4C41),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,

        home: Splash(),
      ),
    );
  }
}
