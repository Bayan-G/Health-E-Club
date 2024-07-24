import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key, required this.Image, required this.onPressed})
      : super(key: key);
  final Widget Image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: onPressed,
            child: Center(
              child: Image,
            ),
          ),
        ]);
  }
}
