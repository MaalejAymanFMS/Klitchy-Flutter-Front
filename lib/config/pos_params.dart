

import 'package:flutter_dotenv/flutter_dotenv.dart';

class PosParams{
  
  static late String apiURL ;
  static late String erpnextURL ;
  static late String token ;
  static late String comapny ;
  static late String productFilter ;
  static late String stores ;
  static late String cash ;
  static late String sales ;
  static late String main ;
  static late String debtors ;
  static late String bank ;
  static Future<void> initialize() async {
    await dotenv.load(fileName: "/.env");
    apiURL = dotenv.env['apiURL']!;
    erpnextURL = dotenv.env['erpnextURL']!;
    token = dotenv.env['token']!;
    comapny = dotenv.env['comapny']!;
    productFilter = dotenv.env['productFilter']!;
    stores = dotenv.env['stores']!;
    cash = dotenv.env['cash']!;
    sales = dotenv.env['sales']!;
    main = dotenv.env['main']!;
    debtors = dotenv.env['debtors']!;
    bank = dotenv.env['bank']!;
  }
}