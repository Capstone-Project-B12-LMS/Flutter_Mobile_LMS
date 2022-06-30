import 'package:capstone_project_lms/provider/listclass_provider.dart';
import 'package:capstone_project_lms/screen/detail_screen.dart';
import 'package:capstone_project_lms/widgets/list_class_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        body: Consumer<GetListClassProvider>(
          builder: (context, data, child) {
            return ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(classId: data.listClass.data?[index].id??'null'),)),
                // Navigator.pushNamed(context, '/detail'),
                child: listClassVertical(
                    data.listClass.data?[index].name ?? '...',
                    data.listClass.data?[index].room ?? '...',
                    data.listClass.data?[index].users?.length.toString() ?? '...'),
              );
            },
            itemCount: data.listClass.data?.length ?? 0,
          );
          },
          // child: 
        ));
  }
}
