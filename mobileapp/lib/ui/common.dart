import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color mTextColor = Color.fromARGB(255, 34, 43, 76);
Color mTextColor2 = Colors.grey;

Color mPrimaryColor = Color.fromARGB(255, 55, 126, 255);
Color mSecondaryColor = Color.fromARGB(255, 241, 243, 246);

const Color lighThemeBackground = Color(0xfff7f7f7);

const SIZE_XSMALL = 12.0;
const SIZE_SMALL = 15.0;
const SIZE_MEDIUM = 18.0;
const SIZE_LARGE = 20.0;
const SIZE_XLARGE = 30.0;
const SIZE_XXLARGE = 45.0;

TextStyle smallTextStyle(Color color, [FontWeight fw = FontWeight.normal]) {
  return TextStyle(fontSize: SIZE_SMALL, color: color, fontWeight: fw);
}

TextStyle xLargeTextStyle(Color color, [FontWeight fw = FontWeight.normal]) {
  return TextStyle(fontSize: SIZE_XLARGE, color: color, fontWeight: fw);
}

TextStyle mediumTextStyle(Color color, [FontWeight fw = FontWeight.normal]) {
  return TextStyle(fontSize: SIZE_MEDIUM, color: color, fontWeight: fw);
}

Widget customFullButton(BuildContext context, String text) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.all(15),
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF0F2027),
          Color(0xFF203A43),
        ],
      ),
    ),
    child: const Text(
      'Calcular IRT',
      style: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
    ),
  );
}

Widget simpleAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    actions: [
      IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(FontAwesomeIcons.times, color: Colors.blueGrey, size: 18),
      )
    ],
  );
}

InputDecoration textFieldDecoration(Widget prefixIcon) {
  return InputDecoration(
    hintText: "0.00",
    suffixText: ' AKZ',
    suffixStyle: xLargeTextStyle(Colors.black, FontWeight.w400),
    prefixIcon: prefixIcon,
    border: InputBorder.none,
  );
}
