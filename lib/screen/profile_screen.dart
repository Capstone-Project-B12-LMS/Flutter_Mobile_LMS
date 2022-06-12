// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/widgets/profile_widgets.dart';
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
  late TextEditingController txtemail;
  late TextEditingController txtfullname;
  late TextEditingController txttelepon;
  @override
  void initState() {
    txtemail = TextEditingController();
    txttelepon = TextEditingController();
    txtfullname = TextEditingController();
    super.initState();
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
                widgetTextField(
                    'Occupation',
                    context
                            .watch<GetUserProvider>()
                            .userDataProvider
                            .data
                            ?.roles?[0]
                            .name ??
                        '...',
                    TextInputType.text,
                    txtemail,
                    false),
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
                                newEmail = txtemail.text;
                              }
                              if (txtfullname.text.isEmpty) {
                                newName = userData.data!.fullName;
                              } else {
                                newName = txtfullname.text;
                              }
                              if (txttelepon.text.isEmpty) {
                                newTelepon = userData.data!.telepon;
                              } else {
                                newTelepon = txttelepon.text;
                              }
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
                                    .getUserData(userId, token);
                                txtemail.clear();
                                txtfullname.clear();
                                txttelepon.clear();
                              });
                            });
                          }
                        } catch (e) {
                          var snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Oops!',
                                message: 'Something wrong..\nTry again later..',
                                contentType: ContentType.success,
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
