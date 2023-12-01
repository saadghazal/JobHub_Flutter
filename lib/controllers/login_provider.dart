import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginNotifier extends ChangeNotifier {

  bool _obscureText = true;

  bool get obscureText => _obscureText;
  set obscureText(bool newState){
    _obscureText = newState;
    notifyListeners();
  }
  bool? _entryPoint;

  bool get entryPoint => _entryPoint ?? false;
  set entryPoint(bool newState){
    _entryPoint = newState;
    notifyListeners();
  }

  bool? _loggedIn;

  bool get loggedIn => _loggedIn ?? false;
  set loggedIn(bool newState){
    _loggedIn = newState;
    notifyListeners();
  }

  getPrefs()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    entryPoint = prefs.getBool('entry_point') ?? false;
    loggedIn = prefs.getBool('logged_in') ?? false;


  }
}
