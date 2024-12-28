import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNavigationButton extends StatefulWidget {
  final String text;
  final Function fun;
  CustomNavigationButton({required this.fun, required this.text});
  @override
  _CustomNavigationButtonState createState() => _CustomNavigationButtonState();
}

class _CustomNavigationButtonState extends State<CustomNavigationButton> {
  late int duration;
  late Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.fun();
      },
      child: MouseRegion(
        onEnter: (val) {
          setState(() {
            duration = 100;
            color = Colors.blue;
          });
        },
        onExit: (val) {
          setState(() {
            duration = 1200;
            color = Colors.black;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: duration ?? 100),
          color: color ?? Colors.black,
          height: 50,
          width: 200,
          child: Center(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    widget.text,
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 21.0),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}