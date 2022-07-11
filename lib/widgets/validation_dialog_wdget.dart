import 'package:capstone_project_lms/provider/getuser_provider.dart';
import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
