import 'package:coin_currency_flutter_app/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurreny = 'AUD';

  DropdownButton<String> androidDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currencyList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton(
        value: selectedCurreny,
        items: dropdownItems,
        onChanged: (value) {
          setState((){
            selectedCurreny = value;
          });
        });
  }

  Map<String, String> coinValues = {};

  bool isWaiting = false;


  void getData() async {
    isWaiting = true;

    try {
      var data = await CoinData().getCoinData(selectedCurreny);

      isWaiting = false;
      setState((){
        coinValues = data;
      });
    } catch(e){
      print(e);
    }
  }



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
              CryptoCard(
                currency: 'USD',
                coin: 'BTC',
              ),
              CryptoCard(
                currency: 'USD',
                coin: 'ETH',
              ),
              CryptoCard(
                currency: 'USD',
                coin: 'LTC',
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.only(bottom: 30.0),
          ),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
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
