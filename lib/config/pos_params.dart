

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../utils/constants.dart';

class PosParams{
  
  static  String? apiURL ;
  static  String? erpnextURL ;
  static  String? token ;
  static  String? comapny ;
  static  String? productFilter ;
  static  String? stores ;
  static  String? cash ;
  static  String? sales ;
  static  String? main ;
  static  String? debtors ;
  static  String? bank ;
  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
    apiURL = dotenv.env['apiURL']??"";
    erpnextURL = dotenv.env['erpnextURL']??"";
    token = dotenv.env['token']??"";
    comapny = dotenv.env['comapny']??"";
    productFilter = dotenv.env['productFilter']??"";
    stores = dotenv.env['stores']??"";
    cash = dotenv.env['cash']??"";
    sales = dotenv.env['sales']??"";
    main = dotenv.env['main']??"";
    debtors = dotenv.env['debtors']??"";
    bank = dotenv.env['bank']??"";
  }
}