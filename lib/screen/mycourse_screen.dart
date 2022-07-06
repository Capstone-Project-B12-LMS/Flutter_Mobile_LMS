import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/screen/detail_screen.dart';
import 'package:capstone_project_lms/widgets/list_class_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/acitiveclass_provider.dart';
import '../provider/material_provider.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({Key? key}) : super(key: key);

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'My Class',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Consumer<ActiveClassProvider>(
          builder: (context, data, _) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await Provider.of<GetMaterialClassProvider>(context,
                            listen: false)
                        .getListClass(
                            data.dataClass.data?[index].id.toString() ??
                                'null');

                    if (mounted) {
                      var dataClass = Provider.of<GetMaterialClassProvider>(
                              context,
                              listen: false)
                          .materialClass
                          .data?[0];
                      try {
                        if (dataClass != null) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DetailScreen(
                                classId:
                                    data.dataClass.data?[index].id.toString(),
                              );
                            },
                          ));
                        } else {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DetailScreen(
                                classId:
                                    data.dataClass.data?[index].id.toString(),
                              );
                            },
                          ));
                          var snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Oops!',
                                message: 'Class Materi is Empty :(',
                                contentType: ContentType.warning,
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } catch (e) {
                        var snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Oops!',
                              message: 'Class Materi is Empty :(',
                              contentType: ContentType.failure,
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: listClassVertical(
                      data.dataClass.data?[index].name ?? '...',
                      data.dataClass.data?[index].room ?? '...',
                      data.dataClass.data?[index].users?.length.toString() ??
                          '...'),
                );
              },
              itemCount: data.dataClass.data?.length ?? 0,
            );
          },
        ));
  }
}
