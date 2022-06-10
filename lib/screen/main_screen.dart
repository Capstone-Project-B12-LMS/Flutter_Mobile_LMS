import 'package:capstone_project_lms/provider/navbar_provider.dart';
import 'package:capstone_project_lms/screen/dashboard_screen.dart';
import 'package:capstone_project_lms/screen/mycourse_screen.dart';
import 'package:capstone_project_lms/screen/setting_screen.dart';
import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.selectedIndex = 0}) : super(key: key);
  final int selectedIndex;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;
  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  List pages = [
    const DashboardScreen(),
    const MyCourseScreen(),
    const SettingScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      context.read<NavbarProvider>().getIndexNavbar(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = Provider.of<NavbarProvider>(context).selectedIndex;
    Color secColor = HexColor('#9EC9E2');
    return Scaffold(
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
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
