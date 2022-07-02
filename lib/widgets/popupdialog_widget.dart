import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class PopUpDialogWidget extends StatelessWidget {
  const PopUpDialogWidget({Key? key, required this.text, required this.type})
      : super(key: key);
  final String text;
  final ContentType type;
  @override
  Widget build(BuildContext context) {
    return Center(child: popUp(text, context));
  }

  popUp(String m, BuildContext context) {
    String title = '';
    if (type == ContentType.failure) {
      title = 'Oops!';
    } else if (type == ContentType.success) {
      title = 'Success!';
    } else {
      title = 'Hmm..';
    }
    var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title,
          message: m,
          contentType: type,
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
