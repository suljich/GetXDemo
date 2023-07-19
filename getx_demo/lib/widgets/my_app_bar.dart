import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    this.title = 'MoneyApp',
    this.canBePopped = false,
  });

  final String title;
  final bool canBePopped;

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight / 1.5,
      );

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        leading: canBePopped ? const CupertinoNavigationBarBackButton() : null,
        title: Center(
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}
