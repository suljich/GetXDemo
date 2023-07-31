import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.title,
    this.canBePopped = false,
  });

  final String title;
  final bool canBePopped;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight / 1.5);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        leading: canBePopped ? const CupertinoNavigationBarBackButton() : null,
        actions: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 10,
              ),
              child: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text('en_US'),
                    onTap: () => Get.updateLocale(
                      const Locale('en', 'US'),
                    ),
                  ),
                  PopupMenuItem(
                    child: const Text('de_DE'),
                    onTap: () => Get.updateLocale(
                      const Locale('de', 'DE'),
                    ),
                  ),
                ],
                child: Text(
                  Get.locale.toString(),
                ),
              ),
            ),
          )
        ],
        title: Center(
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}
