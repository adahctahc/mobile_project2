import 'package:flutter/material.dart';

import 'package:borrowing_mobile/features/browse/screens/browse_screen.dart';
import 'package:borrowing_mobile/features/welcome/welcome_screen.dart';
import 'package:borrowing_mobile/features/request/screens/request_screen.dart';
import 'package:borrowing_mobile/features/history/screens/history_screen.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();

    _widgetOptions = <Widget>[
      BrowseScreen(),
      RequestScreen(
        onBackToHome: () => _onItemTapped(0),
      ),
      const HistoryScreen(),
    ];
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      _showLogoutDialog(); // แสดง popup เมื่อกดปุ่ม Logout
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  // ฟังก์ชันแสดง popup ยืนยันออกจากระบบ
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'ออกจากระบบ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text('คุณต้องการออกจากระบบหรือไม่?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด popup
              },
              child: const Text('ยกเลิก'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด popup
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF06A8A),
              ),
              child: const Text('ออกจากระบบ'),
            ),
          ],
        );
      },
    );
  }

  static const Color activeColor = Color(0xFFF06A8A);
  static const Color inactiveColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _widgetOptions.elementAt(_selectedIndex < 3 ? _selectedIndex : 0),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _selectedIndex < 3 ? _selectedIndex : 0,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Image.asset(
                  'assets/Home.png',
                  color: inactiveColor,
                  width: 28,
                  height: 28,
                ),
                activeIcon: Image.asset(
                  'assets/Home.png',
                  color: activeColor,
                  width: 28,
                  height: 28,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Request',
                icon: Image.asset(
                  'assets/request.png',
                  color: inactiveColor,
                  width: 28,
                  height: 28,
                ),
                activeIcon: Image.asset(
                  'assets/request.png',
                  color: activeColor,
                  width: 28,
                  height: 28,
                ),
              ),
              BottomNavigationBarItem(
                label: 'History',
                icon: Image.asset(
                  'assets/history.png',
                  color: inactiveColor,
                  width: 28,
                  height: 28,
                ),
                activeIcon: Image.asset(
                  'assets/history.png',
                  color: activeColor,
                  width: 28,
                  height: 28,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Logout',
                icon: Image.asset(
                  'assets/logout.png',
                  color: inactiveColor,
                  width: 28,
                  height: 28,
                ),
                activeIcon: Image.asset(
                  'assets/logout.png',
                  color: activeColor,
                  width: 28,
                  height: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}