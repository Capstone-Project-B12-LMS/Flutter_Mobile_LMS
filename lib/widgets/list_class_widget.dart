import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:flutter/material.dart';

Widget listClass(String title, String progress, String role) {
  return SizedBox(
    width: 150,
    child: Card(
      elevation: 5,
      shadowColor: HexColor('#A5CECD'),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.book),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Class as $role',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
                Text(
                  progress,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget listClassVertical(String title, String role, String progress) {
  return ListTile(
    leading: const Icon(Icons.book),
    title: Text(title),
    subtitle: Text(role),
    trailing: Column(
      children: [
        const Text(
          'Members',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        Text(
          progress,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        )
      ],
    ),
  );
}

Widget listClassHorizontal(String title, String role, String progress) {
  return SizedBox(
    height: 150,
    width: 150,
    child: ListTile(
      leading: const Icon(Icons.book),
      title: Text(title),
      subtitle: Text(role),
      trailing: Column(
        children: [
          const Text(
            'Members',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Text(
            progress,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          )
        ],
      ),
    ),
  );
}

Widget listFeedBack(String name, String role, String feedback) {
  return Card(
    elevation: 5,
    shadowColor: HexColor('#9EC9E2'),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.grey,
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(role),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            feedback,
            style: const TextStyle(fontSize: 12),
          ),
        )
      ],
    ),
  );
}

Widget listHistory(String title, String date) {
  return Card(
    elevation: 2,
    shadowColor: HexColor('#9EC9E2'),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(date),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            'Melakukan apapun yang user inginkan',
            style: TextStyle(fontSize: 12),
          ),
        )
      ],
    ),
  );
}
