import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/provider/activityhistory_provider.dart';
import 'package:capstone_project_lms/widgets/list_class_widget.dart';
import 'package:capstone_project_lms/widgets/loading_inscreen_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../widgets/popupdialog_widget.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
      ),
      body: Consumer<ActivityHistoryProvider>(
        builder: (context, value, child) {
          switch (value.dataStatusHistory) {
            case DataStatusHistory.none:
              return Column(
                children: [
                  if (value.activityHistoryProvider.data!.isEmpty)
                    SizedBox(
                      child: LottieBuilder.asset(
                        "assets/emptyScreen.json",
                        fit: BoxFit.fill,
                      ),
                    ),
                  if (value.activityHistoryProvider.data!.isEmpty)
                    const SizedBox(
                        child: Center(
                      child: Text(
                        'Oops, you haven\'t doing anything..',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )),
                  if (value.activityHistoryProvider.data!.isNotEmpty)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return listHistory(
                                value.activityHistoryProvider.data?[index].user
                                        ?.email ??
                                    '..',
                                value.activityHistoryProvider.data?[index]
                                        .content ??
                                    '..',
                                value.activityHistoryProvider.data?[index].user
                                        ?.createdAt ??
                                    []);
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
