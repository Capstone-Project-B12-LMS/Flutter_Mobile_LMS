import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/getuser_provider.dart';

Future<void> showInformationDialog(BuildContext context, String title,
    String subtitle, String buttonText) async {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController textEditingController = TextEditingController();
  Color secColor = HexColor('#415A80');
  return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: textEditingController,
                          cursorColor: secColor,
                          validator: (value) {
                            return value!.isNotEmpty
                                ? null
                                : "Code class Must be filled!";
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Class Code',
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: secColor,
                            ),
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: secColor, width: 2),
                            ),
                          ),
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: secColor))),
                            backgroundColor:
                                MaterialStateProperty.all(secColor)),
                        onPressed: () {
                          Navigator.pop(context);
                          var snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Success!',
                                message: 'Successfully joined the class',
                                contentType: ContentType.success,
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: const Text("JOIN")),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side:
                                        const BorderSide(color: Colors.grey))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("CANCEL")),
                  ),
                ],
              ),
            ),
          );
        });
      });
}

Future<void> validationDialog(
    BuildContext context, String title, String subtitle) async {
  Color secColor = HexColor('#415A80');
  return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: secColor))),
                            backgroundColor:
                                MaterialStateProperty.all(secColor)),
                        onPressed: () async {
                          late SharedPreferences logindata;
                          context.read<GetUserProvider>().clearData();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
                          logindata = await SharedPreferences.getInstance();
                          logindata.remove('token');
                          logindata.remove('userId');
                        },
                        child: const Text("SIGN OUT")),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side:
                                        const BorderSide(color: Colors.grey))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("CANCEL")),
                  ),
                ],
              ),
            ),
          );
        });
      });
}
