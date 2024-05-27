import 'dart:io';

import 'package:flutter/material.dart';

class ProfilePicController extends ChangeNotifier {
 static Map<String, dynamic> photos = {};

  void storeImageForUserId(String userId, File image) {
    photos[userId] = image;
    notifyListeners();
  }
}