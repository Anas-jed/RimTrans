import 'package:flutter/widgets.dart';

import '../export_all.dart';

Widget commongHeaderWidget(final String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Text(
      text,
      style: Constant.kMediumTextStyle.copyWith(fontSize: 11),
    ),
  );
}
