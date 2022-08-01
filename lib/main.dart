import 'package:coin_currency_flutter_app/price_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(BitcoinApp());

class BitcoinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.white),
      home: PriceScreen(),
    );
  }
}
