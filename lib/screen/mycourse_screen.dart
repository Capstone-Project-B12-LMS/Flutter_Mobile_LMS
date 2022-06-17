import 'package:capstone_project_lms/provider/listclass_provider.dart';
import 'package:capstone_project_lms/widgets/list_class_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCourseScreen extends StatelessWidget {
  const MyCourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<GetListClassProvider>(context,listen: false).listClass;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'My Class',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/detail'),
              child: listClassVertical(
                  data.data?[index].name ?? '...',
                  data.data?[index].room ?? '...',
                  data.data?[index].createdBy ?? '...'),
            );
          },
          itemCount: data.data?.length ?? 0,
        ));
  }
}
