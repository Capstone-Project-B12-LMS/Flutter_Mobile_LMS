import 'package:capstone_project_lms/provider/material_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListMemberScreen extends StatelessWidget {
  const ListMemberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Members'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<GetMaterialClassProvider>(
        builder: (context, value, _) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.amber,
                ),
                title: Text(
                  value.materialClass.data?[0].classEntity?.users?[index]
                          .fullName ??
                      '..',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  value.materialClass.data?[0].classEntity?.users?[index]
                          .roles?[0].name ??
                      '..',
                  style: const TextStyle(color: Colors.grey),
                ),
              );
            },
            itemCount:
                value.materialClass.data?[0].classEntity?.users?.length ?? 1,
          );
        },
        // child:
      ),
    );
  }
}
