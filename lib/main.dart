// import 'package:capstone_project_lms/screen/detail_class_screen.dart';
import 'package:capstone_project_lms/provider/login_provider.dart';
import 'package:capstone_project_lms/provider/navbar_provider.dart';
import 'package:capstone_project_lms/screen/login_screen.dart';
import 'package:capstone_project_lms/screen/main_screen.dart';
import 'package:capstone_project_lms/screen/registration_screen.dart';
import 'package:capstone_project_lms/screen/detail_screen.dart';
import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen/profile_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => LoginProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => NavbarProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Space',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            centerTitle: true,
            elevation: 0,
            titleTextStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          )),
      initialRoute: '/main',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/main': (context) => const MainScreen(),
        '/detail': (context) => const DetailScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
