// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences logindata;
  late bool hasLogin;
  late TextEditingController txtemail;
  late TextEditingController txtpassword;
  final formLogin = GlobalKey<FormState>();
  @override
  void initState() {
    checkLogin();
    super.initState();
    txtemail = TextEditingController();
    txtpassword = TextEditingController();
  }

  @override
  void dispose() {
    txtemail.dispose();
    txtpassword.dispose();
    super.dispose();
  }

  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    Color secColor = HexColor('#415A80');
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: formLogin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome Back!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    'We\'re happy to see u again',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email Name must be filled!';
                      }
                      return null;
                    },
                    autocorrect: true,
                    controller: txtemail,
                    keyboardType: TextInputType.name,
                    cursorColor: secColor,
                    decoration: InputDecoration(
                      hintText: 'Enter Email Address',
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: secColor,
                      ),
                      hintStyle: const TextStyle(color: Colors.grey),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: secColor, width: 2),
                      ),
                    ),
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password must be filled!';
                      }
                      return null;
                    },
                    obscureText: isObscure,
                    controller: txtpassword,
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: true,
                    cursorColor: secColor,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: secColor,
                      ),
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: Icon(
                            isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility,
                            color: secColor,
                          )),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: secColor, width: 2),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(secColor)),
                          onPressed: () {
                            final isValidForm =
                                formLogin.currentState!.validate();
                            if (isValidForm) {
                              authLogin(txtemail.text, txtpassword.text);
                            } else {
                              var snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'Oops!',
                                    message: 'Somethng Wrong..',
                                    contentType: ContentType.failure,
                                  ));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              txtpassword.clear();
                            }
                          },
                          child: const Text('Sign In'))),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registration');
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(color: Colors.grey),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  authLogin(String email, String password) async {
    logindata = await SharedPreferences.getInstance();
    final data = await LoginApi().login(email, password);
    if (data.token != null) {
      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      logindata.setString('token', data.token!);
      logindata.setBool('hasLogin', true);
      context.read<LoginProvider>().getUserData(email, password);
      txtemail.clear();
      txtpassword.clear();
    } else {
      logindata.setBool('hasLogin', false);
      logindata.remove('token');
      var snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oops!',
            message: 'Your email / password is wrong or not registered yet!',
            contentType: ContentType.failure,
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  checkLogin() async {
    logindata = await SharedPreferences.getInstance();
    hasLogin = logindata.getBool('hasLogin') ?? false;
    if (hasLogin) {
      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
    }
  }
}
