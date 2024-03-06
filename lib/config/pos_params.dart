

import 'package:flutter_dotenv/flutter_dotenv.dart';

class PosParams{
  
  static late String? ngrokURL="https://prime-verified-pug.ngrok-free.app" ;
  static late String erpnextURL = "https://erpnext-141144-0.cloudclusters.net";
  static late String token = "token 1e36fdb116a0d37:cf66f1ad25b58ba";
  static late String comapny = "Jumpark";
  static late String productFilter = '';
  static late String stores = "Stores_JP";
  static late String cash = "Cash_JP";
  static late String sales = "Sales_JP";
  static late String main = "Main_JP";
  static late String debtors = "Debtors_JP";
  static late String bank = "BTE_JP";
  static Future<void> initialize() async {
    await dotenv.load();
    ngrokURL = dotenv.env['ngrokURL']!;
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