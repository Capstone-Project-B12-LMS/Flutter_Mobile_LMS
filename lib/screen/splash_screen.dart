import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/screen/login_screen.dart';
import 'package:capstone_project_lms/screen/main_screen.dart';
import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../provider/getuser_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences logindata;
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  bool isTrue = false;
  @override
  Widget build(BuildContext context) {
    Color secColor = HexColor('#415A80');
    return SplashScreenView(
      navigateRoute: isTrue ? const MainScreen() : const LoginScreen(),
      duration: 2000,
      imageSize: 300,
      imageSrc: "assets/images/Splash.png",
      text: "Study Space",
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(fontSize: 30.0, color: secColor),
      backgroundColor: Colors.white,
    );
  }

  checkLogin() async {
    logindata = await SharedPreferences.getInstance();
    final token = logindata.getString('token');
    final userId = logindata.getString('userId');
    final newUser = logindata.getBool('newUser');
    if (newUser == false) {
      try {
        if (mounted) {
          context.read<GetUserProvider>().getUserData(userId!, token!);
          setState(() {
            isTrue = true;
          });
          // Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            isTrue = false;
          });
          var snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Oops!',
                message: 'Your session was ended\nplease relogin',
                contentType: ContentType.failure,
              ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } else {
      setState(() {
        isTrue = false;
      });
    }
  }
}
