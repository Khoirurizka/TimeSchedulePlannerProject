import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.elevation = 2.0,
  }) : super(key: key);
  final Widget? title;
  final Widget? leading;
  final double elevation;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 32, 77, 135),
              Color.fromARGB(255, 111, 237, 251),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: AppBar(
          centerTitle: true,
          leading: leading,
          elevation: 0.0,
          title: title,
          backgroundColor: Colors.transparent,
          actions: actions,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
