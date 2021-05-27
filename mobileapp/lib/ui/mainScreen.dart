import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/businessLogic/IRTCalculator.dart';
import 'package:mobileapp/constants/concepts.dart';
import 'package:mobileapp/ui/InformationScreen.dart';
import 'package:mobileapp/ui/common.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  IRTCalculator calculator;
  bool isLoading = false;
  bool isEnabled = false;

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
          backgroundColor: mSecondaryColor,

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
              //level1 ============================================
              Column(
                children: [
                  //top part
                  Card(
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Container(
                      height: screen.height * .32,
                      child: Column(
                        children: [
                          //Salario Base
                          SizedBox(
                            height: 20,
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
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(height: 20),

                        //First section header
                        ListTile(
                            minLeadingWidth: 0,
                            title: Text("Tabela de Resultados",
                                style: smallTextStyle(
                                    mTextColor, FontWeight.bold))),
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

              //leve2 ============================================
              //button to calculate
              Align(
                alignment: Alignment(0, -.3),
                child: ElevatedButton(
                  autofocus: false,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
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
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        horizontal: screen.width * 0.2, vertical: 10)),
                  ),
                  onPressed: isEnabled ? () => calculate() : null,
                  child: Text(
                    "Calcular IRT",
                    style: TextStyle(fontSize: 18),
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
        decoration: textFieldDecoration(IconButton(
          onPressed: () {
            controller.text = 0.00.toString();
            calculate();
          },
          icon: Icon(Icons.clear),
          color: mTextColor2,
        )),
        textAlign: TextAlign.center,
        style: GoogleFonts.sairaCondensed(
            fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.w500),
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
        margin: EdgeInsets.only(top: 10),
        child:
            Text(header, style: smallTextStyle(mTextColor2, FontWeight.w300)));
  }
}
