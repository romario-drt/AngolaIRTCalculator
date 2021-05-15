import 'package:flutter/material.dart';
import 'package:mobileapp/ui/common.dart';

class InformationScreen extends StatefulWidget {
  final String title;
  final String description;

  InformationScreen(this.title, this.description);

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: simpleAppBar(context),
        body: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  widget.title,
                  style: mediumTextStyle(mTextColor, FontWeight.w700),
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(15),
                alignment: Alignment.center,
                child: Text(
                  widget.description,
                  textAlign: TextAlign.justify,
                  style: smallTextStyle(
                    Colors.black,
                    FontWeight.normal,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
