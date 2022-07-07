import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/provider/splash_provider.dart';
import 'package:capstone_project_lms/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/acitiveclass_provider.dart';
import '../provider/getuser_provider.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          child: LoadingWidget(),
        ),
      ),
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
          Navigator.pushNamed(context, '/splash');
        } else {
          Provider.of<SplashProvider>(context, listen: false).setBool(true);
          Provider.of<ActiveClassProvider>(context, listen: false)
              .getActiveClass();
          Navigator.pushNamed(context, '/splash');
        }
      }
    } else {
      Provider.of<SplashProvider>(context, listen: false).setBool(false);
      Navigator.pushNamed(context, '/splash');
    }
  }
}
