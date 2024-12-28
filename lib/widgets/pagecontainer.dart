import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageContainer extends StatefulWidget {
  final String text;
  PageContainer(this.text);
  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          widget.text.toUpperCase(),
          style: GoogleFonts.roboto(
            fontSize: 150,
            fontWeight: FontWeight.w900,
            color: Colors.black26,
          ),
        ),
      ),
    );
  }
}