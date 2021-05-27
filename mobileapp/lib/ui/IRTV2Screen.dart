import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/businessLogic/IRTCalculator.dart';
import 'package:mobileapp/constants/concepts.dart';
import 'package:mobileapp/ui/common.dart';

import 'InformationScreen.dart';

class IRTV2Screen extends StatefulWidget {
  @override
  _IRTV2ScreenState createState() => _IRTV2ScreenState();
}

class _IRTV2ScreenState extends State<IRTV2Screen> {
  IRTCalculator calculator;
  bool isLoading = false;
  bool isEnabled = false;
  bool canClean = false;

  final double minAllowedBaseSalary = 1.00;

  double baseSalary;
  double taxableBonus;
  double zeroCount = 0;

  TextEditingController baseSalaryController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  TextEditingController taxableBonusController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  var formatter = NumberFormat('0,000');

  @override
  void initState() {
    super.initState();
    calculator = new IRTCalculator();

    baseSalaryController.addListener(() {
      setState(() {
        isEnabled =
            double.parse(baseSalaryController.text.replaceAll(",", "")) >=
                minAllowedBaseSalary;

        canClean =
            ((double.parse(baseSalaryController.text.replaceAll(",", "")) > 0 ||
                double.parse(taxableBonusController.text.replaceAll(",", "")) >
                    0));
      });
    });

    taxableBonusController.addListener(() {
      setState(() {
        canClean =
            ((double.parse(baseSalaryController.text.replaceAll(",", "")) > 0 ||
                double.parse(taxableBonusController.text.replaceAll(",", "")) >
                    0));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    baseSalaryController.dispose();
    taxableBonusController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        onLongPress: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: lighThemeBackground,

          //apbar
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  icon: Icon(Icons.chevron_left, color: mTextColor2, size: 22),
                  onPressed: () => Navigator.pop(context)),
              title: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text("IRT",
                    style: smallTextStyle(mTextColor, FontWeight.bold)),
                subtitle: Text("Calculadora por conta de outrem",
                    style: smallTextStyle(mTextColor2)),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon:
                      Icon(FontAwesomeIcons.info, color: mTextColor, size: 16),
                )
              ]),

          //body
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              //level 1
              Column(
                children: [
                  //top part
                  Card(
                    margin: EdgeInsets.all(0),
                    child: Container(
                      height: screen.height * .3,
                      child: Column(
                        children: [
                          //Salario Base
                          SizedBox(
                            height: 10,
                          ),
                          customHeader("Salário Base"),
                          customTextField(baseSalaryController),
                          //subsidio tributavel
                          customHeader("Subsídio Tributável"),
                          customTextField(taxableBonusController),
                        ],
                      ),
                    ),
                  ),

                  //result table

                  SizedBox(height: 40),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      "Resultados",
                      style: xLargeTextStyle(mTextColor, FontWeight.bold),
                    ),
                  ),

                  Expanded(
                    child: ListView(
                      children: [
                        //First section header

                        resultListItem(
                            InformationScreen("Valor Bruto", ccpGrossIncome),
                            "Valor Bruto",
                            calculator.grossIncome,
                            mTextColor),

                        resultListItem(
                            InformationScreen("INSS", ccpGrossIncome),
                            "INSS",
                            calculator.inss,
                            mTextColor),

                        resultListItem(InformationScreen("IRT", ccpGrossIncome),
                            "IRT", calculator.irt, mTextColor),

                        resultListItem(
                            InformationScreen("Valor Líquido", ccpGrossIncome),
                            "Valor Líquido",
                            calculator.netSalary,
                            mPrimaryColor,
                            " AKZ",
                            20.0),

                        //additional information
                        SizedBox(height: 15),

                        ExpansionTile(
                          title: Text(
                            "Informação Adicional",
                            style: smallTextStyle(mTextColor, FontWeight.bold),
                          ),
                          children: [
                            resultListItem(
                                InformationScreen(
                                    "Valor Tributável", ccpGrossIncome),
                                "Valor Tributável",
                                calculator.taxableAmount,
                                mTextColor),
                            resultListItem(
                                InformationScreen(
                                    "Parcela Fixa", ccpGrossIncome),
                                "Parcela Fixe",
                                calculator.fixedParcel,
                                mTextColor),
                            resultListItem(
                                InformationScreen("Excesso", ccpGrossIncome),
                                "Excesso",
                                calculator.excess,
                                mTextColor),
                            resultListItem(
                                InformationScreen("Taxa", ccpGrossIncome),
                                "Taxa",
                                calculator.tax,
                                mTextColor,
                                " %"),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),

              //level 2
              Align(
                alignment: Alignment(0, -.35),
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      //button1
                      ElevatedButton(
                        autofocus: false,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.disabled))
                              return Colors.grey[300];
                            return mPrimaryColor;
                          }),
                          foregroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.disabled))
                              return Colors.grey[600];
                            return Colors.white;
                          }),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10)),
                        ),
                        onPressed: isEnabled ? () => calculate() : null,
                        child: Text(
                          "Calcular",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      //button 2
                      ElevatedButton(
                        autofocus: false,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.disabled))
                              return Colors.grey[300];
                            return mPrimaryColor;
                          }),
                          foregroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.disabled))
                              return Colors.grey[600];
                            return Colors.white;
                          }),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10)),
                        ),
                        onPressed: canClean ? () => calculate() : null,
                        child: Text(
                          "Limpar",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void copyToClipBoard(String title, String value) {
    Clipboard.setData(new ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: mPrimaryColor,
        duration: Duration(milliseconds: 3000),
        content: Text('O valor de $title Foi copiado para a prancheta'),
      ),
    );
  }

  void calculate() {
    baseSalary = _prepareDouble(baseSalaryController.text);
    taxableBonus = _prepareDouble(taxableBonusController.text);
    setState(() {
      isLoading = true;
      calculator.calculate(baseSalary, taxableBonus);
    });
  }

  //Make Sure inoput is in correct format and appropriate number
  double _prepareDouble(String input) {
    if (input.isEmpty) {
      return 0.00;
    } else {
      return double.parse(input.replaceAll(",", ""));
    }
  }

  //specific textfield data for this screen top zone (input)
  Widget customTextField(TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: controller,
        maxLines: 1,
        textInputAction: TextInputAction.done,
        decoration: textFieldDecoration(),
        textAlign: TextAlign.left,
        style: GoogleFonts.sairaCondensed(
            fontSize: 35.0, color: Colors.black, fontWeight: FontWeight.w500),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }

  Widget resultListItem(Widget screen, String title, double value, Color color,
      [String suffix = " AKZ", double size = 14]) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
      onLongPress: () => copyToClipBoard(title, value.toString()),
      child: Container(
        margin: EdgeInsets.only(right: 5),
        child: ListTile(
          minLeadingWidth: 0,
          //leading: Icon(Icons.info_outline, color: mTextColor),
          title:
              Text(title, style: TextStyle(color: Colors.grey, fontSize: 14)),
          trailing: Countup(
            begin: zeroCount,
            end: value,
            suffix: suffix,
            precision: 2,
            duration: Duration(seconds: 1),
            separator: ',',
            style: TextStyle(
                color: color, fontSize: size, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget customHeader(String header) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 10, left: 25),
        child:
            Text(header, style: smallTextStyle(mTextColor2, FontWeight.w300)));
  }
}

InputDecoration textFieldDecoration() {
  return InputDecoration(
    hintText: "0.00",
    prefixText: "Kz ",
    prefixStyle: xLargeTextStyle(Colors.black, FontWeight.w400),
    border: InputBorder.none,
  );
}
