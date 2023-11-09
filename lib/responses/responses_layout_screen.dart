import 'package:flutter/material.dart';
import 'package:ins_clone/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout(this.webScreenLayout, this.mobileScreenLayout,
      {super.key});

  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  @override 
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreen) {
          return webScreenLayout;
        }
        return mobileScreenLayout;
      },
    );
  }
}
