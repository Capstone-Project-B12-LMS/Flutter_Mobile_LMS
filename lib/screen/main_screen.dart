import 'package:capstone_project_lms/provider/join_provider.dart';
import 'package:capstone_project_lms/provider/navbar_provider.dart';
import 'package:capstone_project_lms/screen/dashboard_screen.dart';
import 'package:capstone_project_lms/screen/mycourse_screen.dart';
import 'package:capstone_project_lms/screen/setting_screen.dart';
import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/getclass_response.dart';
import '../provider/listclass_provider.dart';

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
    // loadDataMyCourseScreen();
    // loadDataDashboard();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    loadDataDashboard();
    loadDataMyCourseScreen();
    super.didChangeDependencies();
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

  loadDataMyCourseScreen() async {
    loginData = await SharedPreferences.getInstance();
    String token = loginData.getString('token')!;
    if (mounted) {
      Provider.of<GetListClassProvider>(context, listen: false)
          .getListClass(token);
    }
  }

  loadDataDashboard() async {
    loginData = await SharedPreferences.getInstance();
    String token = loginData.getString('token')!;
    String id = loginData.getString('userId')!;
    if (mounted) {
      Provider.of<JoinProvider>(context, listen: false).savetokenid(id, token);
    }
  }
}
