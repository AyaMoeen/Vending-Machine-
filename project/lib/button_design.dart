// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeButton2 extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  // final BorderRadius borderRadius;
  CustomeButton2({
    // super.key,
    required this.text,
    required this.onPressed,
    // required this.borderRadius,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 150, 62, 7),
        minimumSize: Size(80, 40),
        padding: EdgeInsets.symmetric(horizontal: 10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      /*child: GestureDetector(
        onTap: () {
          //Navigator.of(context).pushReplacementNamed("login");
          // Navigator.push(
          // context, MaterialPageRoute(builder: (context) => Login()));
        },*/
      child: Text(
        text,
        style: GoogleFonts.aBeeZee(
          textStyle: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 18,
          ),
        ),
      ),
      //),
      onPressed: onPressed,
    );
  }
}
