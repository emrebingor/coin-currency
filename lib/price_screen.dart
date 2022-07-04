import 'package:coin_currency_flutter_app/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

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
          setState(() {
            selectedCurreny = value.toString();
          });
        });
  }


  CupertinoPicker IOSPicker(){
    List<Text> pickerItems = [];
    for(String currency in currencyList){
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedIndex){
        setState((){
          selectedCurreny = currencyList[selectedIndex];
          getData();
        });
      },
      children: pickerItems,
    );
  }

  Map<String, String> coinValues = {};

  bool isWaiting = false;

  void getData() async {
    isWaiting = true;

    try {
      var data = await CoinData().getCoinData(selectedCurreny);

      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState(){
    super.initState();
    getData();
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
                coin: 'BTC',
                value: isWaiting ? '' : coinValues['BTC'].toString(),
                currency: selectedCurreny,
              ),
              CryptoCard(
                coin: 'ETH',
                value: isWaiting ? '' : coinValues['ETH'].toString(),
                currency: selectedCurreny,
              ),
              CryptoCard(
                coin: 'LTC',
                value: isWaiting ? '' : coinValues['LTC'].toString(),
                currency: selectedCurreny,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.only(bottom: 30.0),
            child: Platform.isIOS ? IOSPicker() : androidDropdownButton(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  CryptoCard({this.currency, this.coin, this.value});

  final String? currency;
  final String? coin;
  final String? value;

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
            '1 $coin = $value $currency',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
