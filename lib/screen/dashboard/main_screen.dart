import 'package:capstone_project_lms/provider/navbar_provider.dart';
import 'package:capstone_project_lms/screen/dashboard/dashboard_screen.dart';
import 'package:capstone_project_lms/screen/dashboard/activity_screen.dart';
import 'package:capstone_project_lms/screen/dashboard/mycourse_screen.dart';
import 'package:capstone_project_lms/screen/dashboard/setting_screen.dart';
import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/getclass_response.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.selectedIndex = 0}) : super(key: key);
  final int selectedIndex;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late SharedPreferences loginData;
  late ResponseGetListClass listClass;

  late int _selectedIndex;
  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  List pages = [
    const DashboardScreen(),
    const MyCourseScreen(),
    const ActivityScreen(),
    const SettingScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      context.read<NavbarProvider>().getIndexNavbar(index);
    });
  }

  DateTime preBackpress = DateTime.now();
  @override
  Widget build(BuildContext context) {
    _selectedIndex = Provider.of<NavbarProvider>(context).selectedIndex;
    Color secColor = HexColor('#9EC9E2');
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          //show snackbar
          const snack = SnackBar(
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false; // false will do nothing when back press
        } else {
          return true; // true will exit the app
        }
      },
      child: Scaffold(
        body: Center(
          child: pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          backgroundColor: secColor,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'My Class'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'Activity'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
