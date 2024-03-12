import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class TestEnv extends StatefulWidget {
  const TestEnv({super.key});
  @override
  State<TestEnv> createState() => _TestEnvState();
}
class _TestEnvState extends State<TestEnv> {
  String? token;
  loadDot()async {
    setState(() {
      token = dotenv.env['token'];
    });
  }
@override
  Future<void> initState() async {
    //await dotenv.load(fileName: "/.env");
    loadDot();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(token.toString()),));
  }
}