import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color mTextColor = Color.fromARGB(255, 15, 32, 39);
Color mtextCOlor2 = Color.fromARGB(255, 241, 243, 246);
Color mBackground = Color.fromARGB(255, 12, 21, 12);

const SIZE_XSMALL = 12.0;
const SIZE_SMALL = 15.0;
const SIZE_MEDIUM = 18.0;
const SIZE_LARGE = 20.0;
const SIZE_XLARGE = 35.0;
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

Widget customTextField(TextEditingController controller, Function action) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30),
    child: TextField(
      controller: controller,
      maxLines: 1,
      inputFormatters: [
        FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
      ],
      decoration: InputDecoration(
          suffixStyle: xLargeTextStyle(Colors.black, FontWeight.w400),
          suffix: Text("AOA",
              style: xLargeTextStyle(Colors.black, FontWeight.w400)),
          prefixIcon: IconButton(
              onPressed: action,
              icon: Icon(Icons.info_outline, color: mTextColor)),
          border: InputBorder.none,
          hintText: "0.00"),
      textAlign: TextAlign.center,
      style: xLargeTextStyle(Colors.black, FontWeight.w400),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    ),
  );
}
