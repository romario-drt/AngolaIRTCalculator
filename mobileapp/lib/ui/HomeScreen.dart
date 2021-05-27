import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/ui/IRTV2Screen.dart';
import 'package:mobileapp/ui/mainScreen.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'common.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: lighThemeBackground,
        //appbar
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Menu Principal",
              style: mediumTextStyle(mTextColor, FontWeight.bold)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.stream, color: mTextColor, size: 16),
            )
          ],
        ),

        //body
        body: Stack(
          children: [
            //level1
            Container(
              width: screenSize.width,
              height: screenSize.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    lighThemeBackground,
                  ],
                ),
              ),
            ),

            //level 2
            SingleChildScrollView(
              child: Column(
                children: [
                  //welcome
                  SizedBox(height: 30),
                  ListTile(
                    title: Text("CITA",
                        style: xLargeTextStyle(mTextColor, FontWeight.bold)),
                    subtitle: Text("Calculadora de Impostos e Taxas Angolana",
                        style: smallTextStyle(mTextColor2)),
                  ),

                  SizedBox(height: 30),
                  //List of menus
                  _calculatorCard(
                      0.5,
                      context,
                      Icons.work_rounded,
                      mTextColor,
                      "IRT Grupo A",
                      "Contribuentes por conta própria",
                      MainScreen()),

                  _calculatorCard(
                      .8,
                      context,
                      Icons.work_rounded,
                      Colors.green,
                      "IRT Grupo B",
                      "Contribuentes por conta de outrem",
                      MainScreen()),

                  _calculatorCard(
                      1.1,
                      context,
                      Icons.work_rounded,
                      Colors.orange,
                      "IRT Grupo C",
                      "Contribuentes Industriais",
                      MainScreen()),

                  _calculatorCard(1.4, context, Icons.work_rounded, mTextColor,
                      "Calculadora IRT", "Visual Alternativo", IRTV2Screen())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //default card ui with icon
  Widget _calculatorCard(double delay, BuildContext context, IconData icon,
      Color iconColor, String title, String description, Widget screen) {
    return PlayAnimation<double>(
      tween: (0.0).tweenTo(1.0),
      duration: 0.5.seconds,
      delay: delay.seconds, // <-- specify widget called "child"
      builder: (context, child, value) {
        // <-- obtain child from builder function parameter
        return Opacity(
            opacity: value,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => screen)),
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                        color: lighThemeBackground,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: EdgeInsets.all(7),
                    child: Icon(icon, color: iconColor),
                  ),
                  contentPadding: EdgeInsets.all(0),
                  title: Text(title,
                      style: smallTextStyle(mTextColor, FontWeight.bold)),
                  subtitle:
                      Text(description, style: smallTextStyle(mTextColor2)),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: mTextColor,
                  ),
                ),
              ),
            ));
      },
    );
  }
}
