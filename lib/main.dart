import 'package:capstone_project_lms/provider/acitiveclass_provider.dart';
import 'package:capstone_project_lms/provider/activityhistory_provider.dart';
import 'package:capstone_project_lms/provider/feedback_provider.dart';
import 'package:capstone_project_lms/provider/getuser_provider.dart';
import 'package:capstone_project_lms/provider/join_provider.dart';
import 'package:capstone_project_lms/provider/listclass_provider.dart';
import 'package:capstone_project_lms/provider/login_provider.dart';
import 'package:capstone_project_lms/provider/navbar_provider.dart';
import 'package:capstone_project_lms/provider/splash_provider.dart';
import 'package:capstone_project_lms/screen/detailClass/list_member_screen.dart';
import 'package:capstone_project_lms/screen/login/login_screen.dart';
import 'package:capstone_project_lms/screen/dashboard/main_screen.dart';
import 'package:capstone_project_lms/screen/login/registration_screen.dart';
import 'package:capstone_project_lms/screen/detailClass/detail_screen.dart';
import 'package:capstone_project_lms/screen/splash/splash_screen.dart';
import 'package:capstone_project_lms/screen/splash/splash_screen2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/counselling_provider.dart';
import 'screen/dashboard/profile_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => LoginProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => NavbarProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => GetUserProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => GetListClassProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => JoinProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => SplashProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ActiveClassProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CounsellingProvdider(),
      ),
      ChangeNotifierProvider(
        create: (_) => FeedbackProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ActivityHistoryProvider(),
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
          backgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            centerTitle: true,
            elevation: 0,
            titleTextStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          )),
      initialRoute: '/splash2',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/main': (context) => const MainScreen(),
        '/detail': (context) => const DetailScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/members': (context) => const ListMemberScreen(),
        '/splash': (context) => const SplashScreen(),
        '/splash2': (context) => const SplashScreen2(),
      },
    );
  }
}
