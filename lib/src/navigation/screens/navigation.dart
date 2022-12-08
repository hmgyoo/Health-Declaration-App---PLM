import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ihdplm_new/src/dashboard/screens/reminders.dart';
import 'package:ihdplm_new/src/utils/constant.dart';
import 'package:line_icons/line_icons.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _page = 0;

  List<Widget> _screens = [
    RemindersScreen(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_page],
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: kBackgroundColor,
        color: kPrimaryColor,
        height: 60.0,
        buttonBackgroundColor: kPrimaryColor,
        animationDuration: Duration(milliseconds: 300),
        items: [
          Icon(LineIcons.home, color: kBackgroundColor),
          Icon(LineIcons.heart, color: kBackgroundColor),
          Icon(LineIcons.medicalBriefcase, color: kBackgroundColor),
          Icon(LineIcons.calendar, color: kBackgroundColor),
          Icon(LineIcons.user, color: kBackgroundColor),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        index: _page,
      ),
    );
  }
}
