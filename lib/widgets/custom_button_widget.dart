import 'package:flutter/material.dart';

import '../export_all.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color buttonColor;
  final bool isDisable;
  final Widget? suffix;
  final TextStyle? textStyle;
  final double width;
  final double height;
  final Widget? prefix;
  final bool isLoading;
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.buttonColor = primaryColor,
      this.suffix,
      this.prefix,
      this.textStyle,
      this.width = double.infinity,
      this.height = 55,
      this.isLoading = false,
      this.isDisable = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: isDisable ? disableGreyColor : buttonColor,
            borderRadius: BorderRadius.circular(20)),
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefix != null) ...[
              Align(alignment: Alignment.centerLeft, child: prefix!)
            ],
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: isLoading
                    ? const SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeCap: StrokeCap.round,
                          strokeWidth: 3,
                        ),
                      )
                    : Text(
                        text,
                        style: textStyle ?? getDefaultTextStyle(isDisable),
                      ),
              ),
            ),
            if (suffix != null && isLoading == false) ...[
              Align(alignment: Alignment.centerRight, child: suffix!)
            ]
          ],
        ),
      ),
    );
  }
}

TextStyle getDefaultTextStyle(bool isDisable) {
  return TextStyle(
      color: isDisable ? Colors.grey : Colors.white,
      fontWeight: FontWeight.w500);
}
