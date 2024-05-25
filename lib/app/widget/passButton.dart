import 'package:flutter/material.dart';
import '../services/screenAdapter.dart';

class PassButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const PassButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
      height: ScreenAdapter.height(140),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(Color.fromRGBO(240, 115, 49, 1)),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(ScreenAdapter.height(70))))),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: ScreenAdapter.fontSize(46)),
        ),
      ),
    );
  }
}
