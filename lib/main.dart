import 'package:flutter/material.dart';
import 'package:noteapp/data/local_data_source.dart';
import 'package:noteapp/view/screens/splachscr.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedprefernces;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedprefernces = await SharedPreferences.getInstance();
  await LocalDataSource.init(); // ← هذا ضروري
  runApp(const First());
}

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplachScr());
  }
}
