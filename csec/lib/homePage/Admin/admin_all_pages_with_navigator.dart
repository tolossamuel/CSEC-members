import 'package:csec/homePage/Admin/admin_home_pages.dart';
import 'package:csec/homePage/Admin/attendace_managements.dart';
import 'package:csec/homePage/Admin/members_list.dart';
import 'package:csec/homePage/Memebers/atendance.dart';
import 'package:csec/homePage/Memebers/home.dart';
import 'package:csec/homePage/Memebers/profile.dart';
import 'package:csec/theming/change.dart';
import 'package:csec/theming/themes.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class AdminNavigatorButtons extends StatelessWidget {
  final List<dynamic> uid;
  const AdminNavigatorButtons({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(uid[0], uid[1]),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Provider.of<ThemeProvider>(context).themeData ==
              lightMode
          ? const Color.fromARGB(255, 235, 235, 235) // Use light primary color
          : Color.fromARGB(255, 28, 28, 28), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}

List<Widget> _buildScreens(String id, String password) {
  return [
    AdminHomePages(),
    MembersListViews(password: password),
    AttendanceManage(),
    Profile(id: id)
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home),
      title: ("Home"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.amber,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.group),
      title: ("Members"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.amber,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.present_to_all),
      title: ("Attendance"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.amber,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      title: ("Profile"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.amber,
    ),
  ];
}
