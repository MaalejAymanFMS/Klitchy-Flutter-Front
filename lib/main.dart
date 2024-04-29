import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:klitchyapp/config/pos_params.dart';
import 'package:klitchyapp/firebase_options.dart';
import 'package:klitchyapp/routes/routes.dart';
import 'package:klitchyapp/utils/locator.dart';
import 'package:klitchyapp/views/kitchen.dart';
import 'package:klitchyapp/views/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:klitchyapp/utils/AppState.dart' as UtilAppState;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final remoteConfigInstance = FirebaseRemoteConfig.instance;
await remoteConfigInstance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
));
 String? downloadURL = await _getDownloadURL("config/envv.json");
  if (downloadURL != null) {
    String? jsonString = await _readFileFromURL(downloadURL);
    print(jsonString);
    if (jsonString != null) {
      Map<String, dynamic> config = jsonDecode(jsonString);
      // Utilisez votre configuration ici
    }
  }
setupLocator();

  runApp(const MyApp());
}

Future<String> _getDownloadURL(String path) async {
  final FirebaseStorage storage = FirebaseStorage.instance;
  try {
    String downloadURL = await storage.ref(path).getDownloadURL();
    print("Successfully retrieved download URL: $downloadURL");
    return downloadURL;
  } catch (e) {
    print("Error getting download URL: $e");
    return '';
  }
}

Future<String?> _readFileFromURL(String? url) async {
  if (url == null || url.isEmpty) {
    print("URL is empty or null");
    return null;
  }
final proxyUrl = 'https://cors-anywhere.herokuapp.com/$url';

  try {
    final response = await http.get(Uri.parse(proxyUrl), headers: {
      'Access-Control-Allow-Origin': '*',  // ou 'https://votre-domaine.com' si vous connaissez l'origine
    });
    if (response.statusCode == 200) {
      print("Received data: ${response.body}");
    
      return response.body;
    } else {
      print("Failed to load data from URL. Status code: ${response.statusCode}");
      print("Received data: ${response.body}");
      return null;
    }
  } catch (e) {
    print("Error reading data from URL: $e");
    return null;
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
