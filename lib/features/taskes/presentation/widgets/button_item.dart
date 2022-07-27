
import 'package:flutter/material.dart';

class ButtonItem extends StatelessWidget {
  final String title;
  final Function onClick;
  const ButtonItem({Key? key,
    required this.title,
    required this.onClick

    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:  new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
          ),
            primary: Colors.green,
            textStyle: TextStyle(
                fontSize: 20,
                )),
        onPressed: () {
          onClick();
        },
        child:  Text(title),
      ),
    );
  }
}
