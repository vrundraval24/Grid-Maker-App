import 'package:flutter/material.dart';

import '../utils/validation_function.dart';

class CustomDialogBox {
  final BuildContext context;
  final String imagePath;
  final Size mq;
  final TextEditingController controller;
  final String dialogueBoxTitle;
  final String hintText;
  final String dialogButtonName;
  final Function action;

  CustomDialogBox({
    required this.context,
    required this.imagePath,
    required this.mq,
    required this.controller,
    required this.dialogueBoxTitle,
    required this.hintText,
    required this.dialogButtonName,
    required this.action,
  });

  customDialogFunction(){
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          
          title: Text(dialogueBoxTitle),
          content: Form(
            key: formKey,
            child: TextFormField(
              validator: (value) {
                if (value != null) {
                  return Validation.validationFunction(value);
                }

                return null;
              },
              controller: controller,
              decoration: InputDecoration(hintText: hintText),
              autofocus: true,
              keyboardType: TextInputType.number,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  action();
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                      side: const BorderSide(color: Colors.black))),
              child: Text(dialogButtonName),
            ),
          ],
        );
      },
    );
  }
}

// customDialogueBox(
//   BuildContext context,
//   String imagePath,
//   Size mq,
//   TextEditingController controller,
//   String dialogueBoxTitle,
//   String hintText,
//   String dialogButtonName,
//   Function action,
// ) {
//
// }
