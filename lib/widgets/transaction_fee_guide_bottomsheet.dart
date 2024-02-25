import 'package:flutter/material.dart';

import '../export_all.dart';

void showTransactionFeeGuideBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      // constraints: BoxConstraints(
      //   minHeight: MediaQuery.of(context).size.height * 0.8,
      // ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 38.0, horizontal: 26.0),
            child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trasnsaction Fee Guide',
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
                          size: 24.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Amount Rate',
                        textAlign: TextAlign.center,
                        style: Constant.kMediumTextStyle.copyWith(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Fee Charged',
                        textAlign: TextAlign.center,
                        style: Constant.kMediumTextStyle.copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: Constant.feeGuideList.length,
                    // scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = Constant.feeGuideList[index];
                      return Container(
                        height: 55,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: index % 2 != 0
                                ? const Color(0xfffafafa)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.range,
                                  textAlign: TextAlign.center,
                                  style: Constant.kRegularTextStyle
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  item.fee,
                                  textAlign: TextAlign.center,
                                  style: Constant.kRegularTextStyle
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                            ]),
                      );
                    })
              ]),
            ),
          );
        });
      });
}
