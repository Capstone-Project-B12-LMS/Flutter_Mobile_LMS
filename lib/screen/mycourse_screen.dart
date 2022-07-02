import 'package:capstone_project_lms/screen/detail_screen.dart';
import 'package:capstone_project_lms/widgets/list_class_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/acitiveclass_provider.dart';
import '../provider/material_provider.dart';

class MyCourseScreen extends StatelessWidget {
  const MyCourseScreen({Key? key}) : super(key: key);

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
          builder: (context, data, child) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Provider.of<GetMaterialClassProvider>(context,
                            listen: false)
                        .getListClass(data.dataClass.data?[index].id ?? 'null');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                              classId:
                                  data.dataClass.data?[index].id ?? 'null'),
                        ));
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
