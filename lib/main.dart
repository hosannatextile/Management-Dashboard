import 'package:flutter/material.dart';
import 'package:help_desk_hosanna/dashboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:help_desk_hosanna/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

   Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return ScreenUtilInit(
    designSize: const Size(1366, 768),
    minTextAdapt: true, // optional, but recommended
    splitScreenMode: true, // optional, but recommended
    builder: (context, child) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:LoginScreen(),
    );
    }
    );
  }
}
