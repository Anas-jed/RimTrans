import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../export_all.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static Future start(BuildContext context) {
    if (Platform.isIOS) {
      return Navigator.push(context,
          CupertinoPageRoute(builder: (context) => const SettingsScreen()));
    } else {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()));
    }
  }

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool dispalySwitch, notificationSwitch;

  @override
  void initState() {
    super.initState();
    dispalySwitch = false;
    notificationSwitch = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBarWidget(
            text: 'Settings',
            onBackTap: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                SwitchListItem(
                    text: 'Display Mode',
                    switchValue: dispalySwitch,
                    switchOn: (value) {
                      setState(() {
                        dispalySwitch = value;
                      });
                    }),
                SwitchListItem(
                    text: 'Notifications',
                    switchValue: notificationSwitch,
                    isShadow: true,
                    switchOn: (value) {
                      setState(() {
                        notificationSwitch = value;
                      });
                    }),
                LanguageListItem(
                  text: 'Languagues',
                  onTap: () {},
                ),
                CommonListItem(
                  text: 'Profile Settings',
                  isShadow: true,
                  onTap: () {},
                ),
                CommonListItem(
                  text: 'About Us',
                  onTap: () {},
                ),
                CommonListItem(
                  text: 'Term and Condition',
                  isShadow: true,
                  onTap: () {
                    TermAndConditionScreen.start(context);
                  },
                ),
                CommonListItem(
                  text: 'Contact Us',
                  onTap: () {},
                ),
              ],
            ),
          )),
    );
  }
}

class LanguageListItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const LanguageListItem({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SpringWidget(
      onTap: onTap,
      child: Container(
        height: 55,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            text,
            style: Constant.kMediumTextStyle.copyWith(fontSize: 13),
          ),
          Row(
            children: [
              Text(
                'English',
                style: Constant.kRegularTextStyle.copyWith(fontSize: 11),
              ),
              const SizedBox(
                width: 10.0,
              ),
              const Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: Colors.grey,
              ),
            ],
          )
        ]),
      ),
    );
  }
}

class SwitchListItem extends StatefulWidget {
  final bool isShadow;
  final String text;
  final bool switchValue;
  final Function(bool) switchOn;
  const SwitchListItem(
      {super.key,
      this.isShadow = false,
      required this.text,
      required this.switchValue,
      required this.switchOn});

  @override
  State<SwitchListItem> createState() => _SwitchListItemState();
}

class _SwitchListItemState extends State<SwitchListItem> {
  late bool switchV;

  @override
  void initState() {
    super.initState();
    switchV = widget.switchValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: widget.isShadow ? const Color(0xfffafafa) : Colors.white,
          borderRadius: BorderRadius.circular(15)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          widget.text,
          style: Constant.kMediumTextStyle.copyWith(fontSize: 13),
        ),
        Theme(
          data: ThemeData(
            useMaterial3: true,
          ).copyWith(
            colorScheme:
                Theme.of(context).colorScheme.copyWith(outline: Colors.white),
          ),
          child: FlutterSwitch(
            value: switchV,
            width: 48.0,
            toggleSize: 25.0,
            padding: 2.0,
            activeColor: primaryColor,
            inactiveColor: const Color(0xfff0f0f0),
            onToggle: (value) {
              setState(() {
                switchV = value;
              });
              widget.switchOn(value);
            },
          ),
          // Switch(
          //     value: switchV,
          //     // focusColor: Colors.transparent,
          //     // trackColor: MaterialStateProperty.resolveWith<Color>(
          //     //     (Set<MaterialState> states) {
          //     //   return primaryColor;
          //     // }),
          //     trackOutlineWidth: null,
          //     // trackOutlineColor: Colors.transparent,
          //     activeTrackColor: primaryColor,
          //     inactiveTrackColor: const Color(0xfff0f0f0),
          //     inactiveThumbColor: Colors.white,
          //     onChanged: (value) {
          //       setState(() {
          //         switchV = value;
          //       });
          //       widget.switchOn(value);
          //     }),
        )
      ]),
    );
  }
}

class CommonListItem extends StatelessWidget {
  final bool isShadow;
  final String text;
  final VoidCallback onTap;
  const CommonListItem(
      {super.key,
      this.isShadow = false,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SpringWidget(
      onTap: onTap,
      child: Container(
        height: 55,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: isShadow ? const Color(0xfffafafa) : Colors.white,
            borderRadius: BorderRadius.circular(15)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            text,
            style: Constant.kMediumTextStyle.copyWith(fontSize: 13),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            size: 20,
            color: Colors.grey,
          )
        ]),
      ),
    );
  }
}
