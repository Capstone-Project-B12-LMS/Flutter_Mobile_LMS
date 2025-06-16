import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fzregex/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';

import '../../widgets/hexcolor_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController txtemail;
  late TextEditingController txtpassword;
  late TextEditingController txtfullname;
  late TextEditingController txtusername;
  late TextEditingController txttelp;
  final formRegis = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    txtemail = TextEditingController();
    txtpassword = TextEditingController();
    txtfullname = TextEditingController();
    txtusername = TextEditingController();
    txttelp = TextEditingController();
  }

  @override
  void dispose() {
    txtemail.dispose();
    txtpassword.dispose();
    txtfullname.dispose();
    txtusername.dispose();
    txttelp.dispose();
    super.dispose();
  }

  bool isObscure = true;
  bool isSuccess = false;
  @override
  Widget build(BuildContext context) {
    Color secColor = HexColor('#415A80');
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: formRegis,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create an Account',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        Text(
                          'Create your account to access the Study Space!',
                          style: TextStyle(color: Colors.grey, fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Full Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Full Name must be filled!';
                              } else if (value.length <= 2) {
                                return 'Full Name must be > 1 characters!';
                              }
                              return null;
                            },
                            autofocus: true,
                            autocorrect: true,
                            cursorColor: secColor,
                            keyboardType: TextInputType.name,
                            controller: txtfullname,
                            decoration: InputDecoration(
                              hintText: 'Full Name',
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: secColor,
                              ),
                              hintStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white70,
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: secColor, width: 2),
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          'Email Address',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email must be filled!';
                              }
                              return null;
                            },
                            autocorrect: true,
                            controller: txtemail,
                            cursorColor: secColor,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: 'Enter Email Address',
                              prefixIcon: Icon(
                                Icons.email,
                                color: secColor,
                              ),
                              hintStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white70,
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: secColor, width: 2),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'username must be filled!';
                              }
                              return null;
                            },
                            autocorrect: true,
                            controller: txtusername,
                            cursorColor: secColor,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: 'Enter Username',
                              prefixIcon: Icon(
                                Icons.person,
                                color: secColor,
                              ),
                              hintStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white70,
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: secColor, width: 2),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'phone number must be filled!';
                              }
                              return null;
                            },
                            autocorrect: true,
                            controller: txttelp,
                            cursorColor: secColor,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: 'Enter Phone Number',
                              prefixIcon: Icon(
                                Icons.person,
                                color: secColor,
                              ),
                              hintStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white70,
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: secColor, width: 2),
                              ),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password must be filled!';
                              } else if (Fzregex.hasMatch(txtpassword.text,
                                      FzPattern.passwordHard) ==
                                  false) {
                                if (txtpassword.text.length > 15) {
                                  return 'Password must <= 15 character';
                                } else {
                                  return 'Password must be 8-15 characters,\nno spaces and must contain at least 3\nof these characters: 1 uppercase,\n1 number, 1 symbols.';
                                }
                              } else if (txtpassword.text.length > 15) {
                                return 'Password must <= 15 character';
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
                                  color: secColor,
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                  icon: Icon(
                                    isObscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility,
                                  )),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: secColor, width: 2),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all(secColor)),
                                onPressed: () {
                                  final isValidForm =
                                      formRegis.currentState!.validate();
                                  if (isValidForm) {
                                    final bool isValid =
                                        EmailValidator.validate(txtemail.text);
                                    if (isValid &&
                                        Fzregex.hasMatch(txtpassword.text,
                                            FzPattern.passwordHard)) {
                                      signUp(
                                        email: txtemail.text,
                                        password: txtpassword.text,
                                        fullName: txtfullname.text,
                                        telp: txttelp.text,
                                        username: txtusername.text,
                                      );
                                    } else if (isValid == false) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text('Email is not valid!')));
                                      txtpassword.clear();
                                    } else if (Fzregex.hasMatch(
                                            txtpassword.text,
                                            FzPattern.passwordHard) ==
                                        false) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Password must contains at least 8 character, 1 letter, 1 Number, 1 uppercase, 1 symbols, except whitespace')));
                                      // txtRegisPass.clear();
                                    }
                                  }
                                },
                                child: const Text('SIGN UP'))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  signUp(
      {required String email,
      required String password,
      required String fullName,
      required String telp,
      required String username}) async {
    try {
      var response =
          await API().regis(fullName, email, password, telp, username);
      if (response?.status == true) {
        txtemail.clear();
        txtfullname.clear();
        txtpassword.clear();
        var snackBar = const SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Success!',
              message: 'Successfully Registered!',
              contentType: ContentType.success,
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      } else {
        var snackBar = const SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Oops!',
              message: 'Email already taken!\nPlease use another email..',
              contentType: ContentType.warning,
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      var snackBar = const SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oops!',
            message: 'Something Wrong...',
            contentType: ContentType.warning,
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
