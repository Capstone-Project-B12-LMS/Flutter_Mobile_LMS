import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/provider/activityhistory_provider.dart';
import 'package:capstone_project_lms/widgets/list_class_widget.dart';
import 'package:capstone_project_lms/widgets/loading_inscreen_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../widgets/popupdialog_widget.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity"),
        centerTitle: true,
      ),
      body: Consumer<ActivityHistoryProvider>(
        builder: (context, value, _) {
          switch (value.dataStatusHistory) {
            case DataStatusHistory.none:
              return Column(
                children: [
                  if (value.activityHistoryProvider.data!.isEmpty &&
                      value.activityHistoryProvider.data == null)
                    SizedBox(
                      child: LottieBuilder.asset(
                        "assets/emptyScreen.json",
                        fit: BoxFit.fill,
                      ),
                    ),
                  if (value.activityHistoryProvider.data!.isEmpty &&
                      value.activityHistoryProvider.data == null)
                    const SizedBox(
                        child: Center(
                      child: Text(
                        'Oops, you haven\'t doing anything..',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )),
                  if (value.activityHistoryProvider.data!.isNotEmpty &&
                      value.activityHistoryProvider.data != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return listActivity(
                                value.activityHistoryProvider.data?[index].user
                                        ?.email ??
                                    '..',
                                value.activityHistoryProvider.data?[index]
                                        .content ??
                                    '..');
                          },
                          itemCount:
                              value.activityHistoryProvider.data?.length ?? 0,
                        ),
                      ),
                    ),
                ],
              );
            case DataStatusHistory.loading:
              return AlertDialog(
                content: loadingInScreen(),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            case DataStatusHistory.error:
              return PopUpDialogWidget(
                text: 'Something Wrong...',
                type: ContentType.failure,
              );
          }
        },
        // child:
      ),
    );
  }
}
