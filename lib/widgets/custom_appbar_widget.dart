import 'package:flutter/material.dart';

import '../export_all.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;
  final VoidCallback onBackTap;
  const CustomAppBarWidget(
      {super.key, required this.text, required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.5,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GestureDetector(
                  onTap: () {
                    onBackTap();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: disableGreyColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Icon(
                      Icons.chevron_left_rounded,
                      size: 28.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: Constant.kMediumTextStyle.copyWith(fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}
