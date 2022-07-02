// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/widgets/popupdialog_widget.dart';
import 'package:capstone_project_lms/widgets/profile_widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/sign_api.dart';
import '../provider/getuser_provider.dart';
import '../widgets/hexcolor_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController txtemail;
  late final TextEditingController txtfullname;
  late final TextEditingController txttelepon;
  late final TextEditingController txtuser;
  @override
  void initState() {
    txtemail = TextEditingController();
    txttelepon = TextEditingController();
    txtfullname = TextEditingController();
    txtuser = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    txtemail.dispose();
    txtfullname.dispose();
    txttelepon.dispose();
    txtuser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late SharedPreferences logindata;
    Color secColor = HexColor('#415A80');
    final userData = context.watch<GetUserProvider>().userDataProvider;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_sharp,
              color: secColor,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: secColor,
                  radius: 60,
                ),
                const SizedBox(
                  height: 20,
                ),
                widgetTextField(
                    'Name',
                    context
                            .watch<GetUserProvider>()
                            .userDataProvider
                            .data
                            ?.fullName ??
                        '...',
                    TextInputType.name,
                    txtfullname,
                    true),
                widgetTextField(
                    'Email',
                    context
                            .watch<GetUserProvider>()
                            .userDataProvider
                            .data
                            ?.email ??
                        '...',
                    TextInputType.emailAddress,
                    txtemail,
                    true),
                widgetTextField(
                    'Phone Number',
                    context
                            .watch<GetUserProvider>()
                            .userDataProvider
                            .data
                            ?.telepon ??
                        '...',
                    TextInputType.phone,
                    txttelepon,
                    true),
                widgetTextFieldRole(
                  'Occupation',
                  context
                          .watch<GetUserProvider>()
                          .userDataProvider
                          .data
                          ?.roles?[0]
                          .name ??
                      '...',
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: secColor))),
                          backgroundColor: MaterialStateProperty.all(secColor)),
                      onPressed: () async {
                        if (txtemail.text == "" &&
                            txtfullname.text == "" &&
                            txttelepon.text == "") {
                          PopUpDialogWidget(
                              text: 'Nothing Changes..',
                              type: ContentType.warning);
                        } else {
                          logindata = await SharedPreferences.getInstance();
                          var token = logindata.getString('token')!;
                          var userId = logindata.getString('userId')!;
                          try {
                            String? newName, newEmail, newTelepon;
                            if (userData.status == true) {
                              setState(() {
                                if (txtemail.text.isEmpty) {
                                  newEmail = userData.data!.email;
                                } else {
                                  final bool isValid =
                                      EmailValidator.validate(txtemail.text);
                                  if (isValid) {
                                    newEmail = txtemail.text;
                                  } else {
                                    var snackBar = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                          title: 'Oops!',
                                          message: 'Email is not valid!',
                                          contentType: ContentType.failure,
                                        ));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                }
                                if (txtfullname.text.isEmpty) {
                                  newName = userData.data!.fullName;
                                } else {
                                  newName = txtfullname.text;
                                }
                                if (txttelepon.text.isEmpty) {
                                  newTelepon = userData.data!.telepon;
                                } else {
                                  if (txttelepon.text.length > 10) {
                                    newTelepon = txttelepon.text;
                                  } else {
                                    var snackBar = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                          title: 'Oops!',
                                          message:
                                              'Phone Number must be at least 11 numeric',
                                          contentType: ContentType.failure,
                                        ));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                }
                                if (newEmail != null &&
                                    newEmail != null &&
                                    newTelepon != null) {
                                  API()
                                      .updateData(userId, token, newEmail!,
                                          newName!, newTelepon!)
                                      .then((value) {
                                    var snackBar = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                          title: 'Success',
                                          message: 'Data saved successfully',
                                          contentType: ContentType.success,
                                        ));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    context
                                        .read<GetUserProvider>()
                                        .getUserData();
                                    txtemail.clear();
                                    txtfullname.clear();
                                    txttelepon.clear();
                                  });
                                }
                              });
                            }
                          } catch (e) {
                            PopUpDialogWidget(
                                text: 'text', type: ContentType.failure);
                          }
                        }
                      },
                      child: const Text(
                        'SAVE',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
