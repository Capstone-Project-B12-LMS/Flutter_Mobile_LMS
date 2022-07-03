import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/provider/splash_provider.dart';
import 'package:capstone_project_lms/screen/login_screen.dart';
import 'package:capstone_project_lms/screen/main_screen.dart';
import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../provider/acitiveclass_provider.dart';
import '../provider/getuser_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  bool isTrue = false;
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

  checkLogin() async {
    if (mounted) {
      await context.read<GetUserProvider>().getUserData();
      if (mounted) {
        var a = Provider.of<GetUserProvider>(context, listen: false)
            .userDataProvider;
        if (a.status == false || a.status == null) {
          Provider.of<SplashProvider>(context, listen: false).setBool(false);
          var snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Oops!',
                message: 'Your session was endded!',
                contentType: ContentType.warning,
              ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          Provider.of<SplashProvider>(context, listen: false).setBool(true);
          Provider.of<ActiveClassProvider>(context, listen: false)
              .getActiveClass();
        }
      }
    } else {
      Provider.of<SplashProvider>(context, listen: false).setBool(false);
    }
  }
}
