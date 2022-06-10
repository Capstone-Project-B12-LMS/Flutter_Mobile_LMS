import 'package:flutter/material.dart';

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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return const ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
            ),
            title: Text(
              'Name',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Role',
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
