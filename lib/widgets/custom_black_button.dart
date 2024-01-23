import 'package:flutter/material.dart';

Widget customBlackButton(String buttonName, Function action){
  return SizedBox(
    width: double.maxFinite,
    child: ElevatedButton(
      onPressed: () {

        action();

      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(color: Colors.black))),
      child: Text(
        buttonName,
      ),
    ),
  );
}