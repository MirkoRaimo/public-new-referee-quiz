import 'package:flutter/foundation.dart';

const String SP_DARK_MODE = "darkMode";


/*
Useful Documentation:
https://medium.com/flutterdevs/using-sharedpreferences-in-flutter-251755f07127#

In short

How to SAVE a data:

addIntToSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('intValue', 123);
}

How to READ a data:

getBoolValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return bool
  bool boolValue = prefs.getBool('boolValue'); => here you can use getString('key'); getBool('key'); getInt('key'); getDouble('key');
  return boolValue;
}

How to REMOVE a data:

removeValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Remove String
  prefs.remove("stringValue");
  //Remove bool
  prefs.remove("boolValue");
  //Remove int
  prefs.remove("intValue");
  //Remove double
  prefs.remove("doubleValue");
}

*/