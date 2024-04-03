import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:klitchyapp/config/pos_params.dart';
import 'package:klitchyapp/routes/routes.dart';
import 'package:klitchyapp/utils/locator.dart';
import 'package:klitchyapp/views/kitchen.dart';
import 'package:klitchyapp/views/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:klitchyapp/utils/AppState.dart' as UtilAppState;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load( fileName: '.env');
  await updateRemoteConfig();

  runApp(MyApp());
}


Future<void> updateRemoteConfig() async {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  String apiUrl = dotenv.env['apiURL'] ?? "";
  String erpnextURL = dotenv.env['erpnextURL'] ?? "";
  String token = dotenv.env['token'] ?? "";
  String company = dotenv.env['company'] ?? "";
  String productFilter = dotenv.env['productFilter'] ?? "";
  String stores = dotenv.env['stores'] ?? "";
  String cash = dotenv.env['cash'] ?? "";
  String sales = dotenv.env['sales'] ?? "";
  String main = dotenv.env['main'] ?? "";
  String debtors = dotenv.env['debtors'] ?? "";
  String bank = dotenv.env['bank'] ?? "";
  print("bank : $bank");
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 2),
    minimumFetchInterval: const Duration(hours: 1),
  ));

  await remoteConfig.setDefaults({
    'api_url': apiUrl,
    'erpnext_url': erpnextURL,
    'token': token,
    'company': company,
    'product_filter': productFilter,
    'stores': stores,
    'cash': cash,
    'sales': sales,
    'main': main,
    'debtors': debtors,
    'bank': bank,
  });

  try {
    await remoteConfig.fetch();
    await remoteConfig.activate();
  } catch (e) {
    print("Erreur lors de la récupération ou de l'activation de la configuration RemoteConfig : $e");
  }
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UtilAppState.AppState(),
      child: MaterialApp(
        title: 'Klitchy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(Colors.white),
            thumbVisibility: MaterialStateProperty.all(true),
            trackColor: MaterialStateProperty.all(Colors.white38),
            trackVisibility: MaterialStateProperty.all(true),
          ),
        ),
        home: const SplashScreen(),
        routes: PageRoutes().routes(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
