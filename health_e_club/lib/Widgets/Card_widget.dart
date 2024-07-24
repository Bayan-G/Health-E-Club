import 'package:flutter/material.dart';

class Card_widget extends StatelessWidget {

  Card_widget({Key? key, required this.title, required this.img, required this.height, required this.width, this.onTap, this.use, this.botton,}) : super(key: key);

  final String title;
  dynamic onTap;
  dynamic botton;
  final String img;
  final double height;
  final double width;
  dynamic use;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
        child: SizedBox(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Image.asset(
                img,
                height: height,
                width: width,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              if (use == true) botton,
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
