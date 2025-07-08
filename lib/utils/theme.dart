import 'package:flutter/material.dart';

ThemeData basicTheme() => ThemeData(
      hintColor: Colors.white,
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueAccent,
        textTheme: ButtonTextTheme.accent,
      ),
    );