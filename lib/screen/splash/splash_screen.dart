import 'package:capstone_project_lms/provider/splash_provider.dart';
import 'package:capstone_project_lms/screen/login/login_screen.dart';
import 'package:capstone_project_lms/screen/dashboard/main_screen.dart';
import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Color secColor = HexColor('#415A80');
    return Consumer<SplashProvider>(
      builder: (context, value, _) {
        return SplashScreenView(
          navigateRoute:
              value.isTrue ? const MainScreen() : const LoginScreen(),
          duration: 2000,
          imageSize: 300,
          imageSrc: "assets/images/logoSP.png",
          text: "Study Space",
          textType: TextType.TyperAnimatedText,
          textStyle: TextStyle(fontSize: 30.0, color: secColor),
          backgroundColor: Colors.white,
        );
      },
      // child:
    );
  }
}
