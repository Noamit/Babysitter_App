import './babysitter_profile_screen.dart';
import './babysitter_search_screen.dart';
import 'package:baby_sitter/screens/jobs_search_screen.dart';
import 'package:baby_sitter/screens/notifications_screen.dart';
import 'package:baby_sitter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../widgets/main_drawer.dart';
import '../chats_screen.dart';

class BabysitterMainScreen extends StatefulWidget {
  String? user_body;
  BabysitterMainScreen({Key? key, this.user_body}) : super(key: key);
  static final routeName = 'BabysitterMainScreen';

  @override
  State<BabysitterMainScreen> createState() => _BabysitterMainScreenState();
}

class _BabysitterMainScreenState extends State<BabysitterMainScreen> {
  List<Widget> _screens = [];
  List<String> _screenName = [];
  String screen_name = '';
  String? user_body;

  @override
  void initState() {
    super.initState();
    screen_name = 'Your Profile';
    AuthService.setupPushNotifications();
  }

  @override
  void didChangeDependencies() {
    if (widget.user_body == null) {
      user_body = ModalRoute.of(context)!.settings.arguments as String;
    } else {
      setState(() {
        user_body = widget.user_body;
      });
    }
    _screens = [
      JobsSearchScreen(
        user_body: user_body!,
      ),
      NotificationScreen(),
      BabysitterSearchScreen(),
      ChatsScreen(),
      BabysitterProfileScreen(
        user_body: user_body!,
      )
    ];
    _screenName = [
      'Job Search',
      'Notifications',
      'Search for babysitter',
      'Inbox',
      'Your Profile'
    ];
    super.didChangeDependencies();
  }

  void updateUser(String edit_user) {
    setState(() {
      user_body = edit_user;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Home"),
          textStyle: GoogleFonts.workSans(
            textStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black.withOpacity(0.5),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.notifications),
          title: ("Notifications"),
          textStyle: GoogleFonts.workSans(
            fontSize: 12,
            textStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black.withOpacity(0.5),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.search, color: Colors.white),
          title: ("Search"),
          textStyle: GoogleFonts.workSans(
            textStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black.withOpacity(0.5),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.email),
          title: ("Inbox"),
          textStyle: GoogleFonts.workSans(
            textStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black.withOpacity(0.5),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: ("Profile"),
          textStyle: GoogleFonts.workSans(
            textStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black.withOpacity(0.5),
        ),
      ];
    }

    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 4);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          screen_name,
          style: GoogleFonts.workSans(
            color: Colors.black,
            textStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 129, 100, 110).withOpacity(0.2),
        elevation: 5.0,
      ),
      drawer: MainDrawer(),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _screens,
        items: _navBarsItems(),
        confineInSafeArea: true,
        onItemSelected: (index) {
          setState(() {
            screen_name = _screenName[index];
          });
        },

        backgroundColor:
            Color.fromARGB(255, 214, 204, 208), // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: false, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0.0),
          // colorBehindNavBar: Colors.white,
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
            NavBarStyle.style15, // Choose the nav bar style with this property.
      ),
    );
  }
}
