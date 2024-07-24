import 'package:flutter/material.dart';
import '../Controller/login_controller.dart';
import 'package:get/get.dart';

customButton(context,
    {required String title,
    dynamic style,
    required Color backgroundColor,
    required double width,
    required double height,
    onPressed}) {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    backgroundColor: backgroundColor,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
  );
  final loginController controller = Get.put(loginController());

  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: onPressed,
      style: flatButtonStyle,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: style,
              ),
              if (controller.loading.value)
                SizedBox(
                  width: 20,
                ),
              if (controller.loading.value)
                const Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      color: Colors.black26,
                      strokeWidth: 2,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}
