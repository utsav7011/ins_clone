import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ins_clone/utils/global_variables.dart';

import '../utils/colors.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({
    super.key,
  });

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  late PageController pageController;

  int _page = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // ignore: non_constant_identifier_names
  void NavigationTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          "assets/ic_instagram.svg",
          color: Colors.white,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () => NavigationTapped(0),
            color: _page == 0 ? primaryColor : secondaryColor,
            icon: Icon(Icons.home),
          ),
          IconButton(
            onPressed: () => NavigationTapped(1),
            color: _page == 1 ? primaryColor : secondaryColor,
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => NavigationTapped(2),
            color: _page == 2 ? primaryColor : secondaryColor,
            icon: Icon(Icons.add_a_photo),
          ),
          IconButton(
            onPressed: () => NavigationTapped(3),
            color: _page == 3 ? primaryColor : secondaryColor,
            icon: Icon(Icons.favorite_outline_outlined),
          ),
          IconButton(
            onPressed: () => NavigationTapped(4),
            color: _page == 4 ? primaryColor : secondaryColor,
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
