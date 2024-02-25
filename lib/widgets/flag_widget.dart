import 'package:flutter/material.dart';

import '../export_all.dart';

class FlagWidget extends StatefulWidget {
  final Function(int) selectedIndex;
  const FlagWidget({super.key, required this.selectedIndex});

  @override
  State<FlagWidget> createState() => _FlagWidgetState();
}

class _FlagWidgetState extends State<FlagWidget> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Constant.flagList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = Constant.flagList[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SpringWidget(
              onTap: () {
                widget.selectedIndex(index);
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Image.asset(
                    item.asset,
                    height: 60,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  item.name,
                  style: TextStyle(
                      fontWeight: selectedIndex == index
                          ? FontWeight.w800
                          : FontWeight.w400,
                      fontSize: 12),
                )
              ]),
            ),
          );
        });
  }
}
