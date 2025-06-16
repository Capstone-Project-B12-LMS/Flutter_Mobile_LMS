import 'package:capstone_project_lms/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(
      builder: (context, value, _) {
        if (value.isTrue) {
          value.checkLogin(context);
        }
        return Image.asset(
          "assets/images/Splash.png",
          fit: BoxFit.cover,
        );

        // SplashScreenView(
        //   navigateRoute:
        //       value.isTrue ? const MainScreen() : const LoginScreen(),
        //   duration: 2000,
        //   imageSize: 300,
        //   imageSrc: "assets/images/logoSP.png",
        //   text: "Study Space",
        //   textType: TextType.TyperAnimatedText,
        //   textStyle: TextStyle(fontSize: 30.0, color: secColor),
        //   backgroundColor: Colors.white,
        // );
      },
      // child:
    );
  }
}
