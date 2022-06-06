import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late SharedPreferences logindata;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: const Card(
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
              logindata = await SharedPreferences.getInstance();
              logindata.remove('token');
              logindata.setBool('hasLogin', false);
            },
            child: const Card(
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Sign Out'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
