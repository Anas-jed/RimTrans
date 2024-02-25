import 'dart:developer';

import 'package:flutter/material.dart';

class NewTransactionController extends ChangeNotifier {
  bool isLoading = false;

  setIsLoading(bool value) async {
    log('oldValue: $isLoading');
    isLoading = value;
    log('newValue: $isLoading');
    notifyListeners();
  }
}
