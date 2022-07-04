import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CryptoCard(currency: 'USD', coin: 'BTC',),
              CryptoCard(currency: 'USD', coin: 'ETH',),
              CryptoCard(currency: 'USD', coin: 'LTC',),
            ],
          ),
          Container(),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {

  CryptoCard({required this.currency, required this.coin});

  String currency;
  String coin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 15.0),
          child: Text(
            '1 $currency = ?? $coin',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
