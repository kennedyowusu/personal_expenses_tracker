import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/views/dashboard/dashboard.dart';
import 'package:personal_expenses_tracker/views/expenses/expenditure_screen.dart';
import 'package:personal_expenses_tracker/views/settings/settings_screen.dart';

class TabLayout extends StatefulWidget {
  const TabLayout({super.key, this.selectedIndex = 0});

  final int selectedIndex;

  @override
  State<TabLayout> createState() => _TabLayoutState();
}

class _TabLayoutState extends State<TabLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Dashboard(),
    const ExpenditureScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: textColor,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
        enableFeedback: false,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.grey,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.home,
              color: primaryColor,
              size: 24,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.payments,
              color: Colors.grey,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.payments,
              color: primaryColor,
              size: 24,
            ),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 24,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.settings,
              color: primaryColor,
              size: 24,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
