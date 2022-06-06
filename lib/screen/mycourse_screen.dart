import 'package:capstone_project_lms/widgets/list_class_widget.dart';
import 'package:flutter/material.dart';

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
        body: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/detail'),
              child: listClassVertical(
                  'Class Name ${index + 1}', 'Admin', '${index * 2 + 60}'),
            );
          },
        )

        // CustomScrollView(
        //   slivers: [
        //     GestureDetector(
        //       onTap: () => Navigator.pushNamed(context, '/detail'),
        //       child: SliverList(
        //           delegate: SliverChildBuilderDelegate((context, index) {
        //         return listClassVertical(
        //             'Class Name ${index + 1}', 'Admin', '${60 + index * 2}%');
        //       }, childCount: 15)),
        //     ),
        //   ],
        // ),
        );
  }
}
