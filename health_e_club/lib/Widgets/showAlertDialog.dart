import 'package:flutter/material.dart';

import 'colors.dart';
import 'customButton.dart';

showAlertDialog(BuildContext context,
    {String title = "",
    String message = "",
    String titleBtnOne = "Ok",
    String titleBtnTwo = "Close",
    actionBtnOne,
    actionBtnTwo,
    bool showBtnOne = true,
    bool showBtnTwo = true}) {
  Widget btnOne = ElevatedButton(
    child: Text(titleBtnOne),
    onPressed: actionBtnOne,
  );

  Widget btnTwo = customButton(context,
      title: titleBtnTwo,
      backgroundColor: ColorHelper.blue,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      width: 96,
      height: 24,
      onPressed: actionBtnTwo);

  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: TextStyle(color: Theme.of(context).primaryColor),
    ),
    content: Text(message),
    actions: [
      Visibility(visible: showBtnOne, child: btnOne),
      Visibility(visible: showBtnTwo, child: btnTwo),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
