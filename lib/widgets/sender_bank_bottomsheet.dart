import 'package:flutter/material.dart';

import '../export_all.dart';

Future<(Bank?, int)> showSenderBankBottomSheet(
    context, List<Bank> bankList) async {
  Bank? selectedBankModel;
  int selectedIndex = -1;
  await showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            height: MediaQuery.of(context).size.height * 0.9,
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 38.0, horizontal: 26.0),
            child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sender Bank',
                      style: Constant.kMediumTextStyle.copyWith(fontSize: 22),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xfff3f3f3),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(
                          Icons.close_rounded,
                          size: 22.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 55,
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: disableGreyColor,
                        filled: true,
                        contentPadding: const EdgeInsets.only(top: 8.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(
                              20,
                            )),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SvgPicture.asset(
                            Constant.searchIcon,
                            // size: 18.0,
                            // height: 5.0,
                            // width: 5.0,
                            colorFilter: const ColorFilter.mode(
                                Color(0xffd9d9d9), BlendMode.srcIn),
                            // color: Color(0xffd9d9d9),
                          ),
                        ),
                        hintText: 'Search',
                        hintStyle: Constant.kMediumTextStyle.copyWith(
                            fontSize: 14, color: const Color(0xffd9d9d9))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    itemCount: bankList.length,
                    // scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      final item = bankList[index];
                      return SpringWidget(
                        onTap: () {
                          selectedBankModel = item;
                          selectedIndex = index;
                          // return selectedBankModel;
                          Navigator.pop(
                              context, [selectedBankModel, selectedIndex]);
                        },
                        child: SizedBox(
                            height: 60,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(45),
                                  child: CachedNetworkImage(
                                    imageUrl: item.logo,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(Constant.noPhoto),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item.status == '1'
                                          ? 'Active'
                                          : 'Not Active',
                                      style: Constant.kRegularTextStyle
                                          .copyWith(
                                              color: item.status == '1'
                                                  ? Colors.green
                                                  : const Color(0xffb9b9b9),
                                              fontSize: 11),
                                    ),
                                    Text(
                                      item.bankName,
                                      style: Constant.kRegularTextStyle
                                          .copyWith(fontSize: 14),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      );
                    })
              ]),
            ),
          );
        });
      });
  return (selectedBankModel, selectedIndex);
}
