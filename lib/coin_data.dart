// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currencyList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> coinList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'F7550CDD-FD22-4F52-9B0E-943168B7182E';


class CoinData {

  Future<Map<String, String>> getCoinData(String selectedCurrency) async{

    Map<String, String> cryptoPrices = {};
    for (String crypto in coinList){

      String requestUrl = '$coinAPIUrl/$crypto/$selectedCurrency?apiKey=$apiKey';
      http.Response response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200){
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else{
        print(response.statusCode);
        throw 'Problem with get request';
      }
    }
    return cryptoPrices;
  }
}