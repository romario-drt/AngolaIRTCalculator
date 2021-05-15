import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/businessLogic/IRTCalculator.dart';
import 'package:mobileapp/constants/concepts.dart';
import 'package:mobileapp/ui/InformationScreen.dart';
import 'package:mobileapp/ui/common.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  IRTCalculator calculator;

  double baseSalary;
  double taxableBonus;
  double zeroCount = 0;

  TextEditingController baseSalaryController = TextEditingController();
  TextEditingController taxableBonusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    calculator = new IRTCalculator();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: mtextCOlor2,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    appbar(),
                    //Salario Base
                    customHeader("Salário Base"),
                    customTextField(baseSalaryController, () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => InformationScreen(
                              "Salário Base", ccpBaseSalary)));
                    }),
                    //subsidio tributavel
                    customHeader("Subsídio Tributável"),
                    customTextField(taxableBonusController, () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => InformationScreen(
                              "Subsídio Tributável", ccpTaxableBonus)));
                    }),
                  ],
                ),
              ),
            ),

            //result table
            Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      resultListHeader("Tabela de Resultados",
                          Icon(Icons.keyboard_arrow_down)),
                      resultListItem(
                          InformationScreen("Valor Bruto", ccpGrossIncome),
                          "Valor Bruto",
                          calculator.grossIncome,
                          mTextColor),

                      resultListItem(InformationScreen("INSS", ccpGrossIncome),
                          "INSS", calculator.inss, mTextColor),

                      resultListItem(
                          InformationScreen("Valor Tributável", ccpGrossIncome),
                          "Valor Tributável",
                          calculator.taxableAmount,
                          mTextColor),

                      resultListItem(InformationScreen("IRT", ccpGrossIncome),
                          "IRT", calculator.irt, mTextColor),

                      resultListItem(
                          InformationScreen("Valor Líquido", ccpGrossIncome),
                          "Valor Líquido",
                          calculator.netSalary,
                          Colors.green),

                      //additional information
                      SizedBox(height: 15),
                      resultListHeader("Informação Adicional",
                          Icon(Icons.keyboard_arrow_down)),
                      resultListItem(
                          InformationScreen("Parcela Fixe", ccpGrossIncome),
                          "Parcela Fixe",
                          calculator.fixedParcel,
                          mTextColor),

                      resultListItem(
                          InformationScreen("Excesso", ccpGrossIncome),
                          "Excesso",
                          calculator.excess,
                          mTextColor),

                      resultListItem(InformationScreen("Taxa", ccpGrossIncome),
                          "Taxa", calculator.tax, mTextColor, "%"),
                    ],
                  ),
                )),

            //button
            InkWell(
              onTap: () {
                baseSalary = _prepareDouble(baseSalaryController.text);
                taxableBonus = _prepareDouble(taxableBonusController.text);
                setState(() {
                  calculator.calculate(baseSalary, taxableBonus);
                });
              },
              child: customFullButton(context, 'Calcular IRT'),
            )
          ],
        ),
      ),
    );
  }

  //if input is not right format convert it back to 0
  double _prepareDouble(input) {
    return (input.isEmpty) ? 0 : double.parse(input);
  }

  Widget resultListHeader(String title, Widget trailing) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      child: ListTile(
          minLeadingWidth: 0,
          title: Text(
            title,
            style: smallTextStyle(mTextColor, FontWeight.bold),
          ),
          trailing: trailing),
    );
  }

  Widget resultListItem(Widget screen, String title, double value, Color color,
      [String suffix = "AOA"]) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
      child: Container(
        margin: EdgeInsets.only(right: 5),
        child: ListTile(
          minLeadingWidth: 0,
          leading: Icon(Icons.info_outline, color: mTextColor),
          title:
              Text(title, style: TextStyle(color: Colors.grey, fontSize: 14)),
          trailing: Countup(
            begin: zeroCount,
            end: value,
            suffix: suffix,
            duration: Duration(seconds: 1),
            separator: ',',
            style: TextStyle(
                color: color, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget appbar() {
    return ListTile(
      title:
          Text("Angola", style: TextStyle(color: Colors.black, fontSize: 14)),
      subtitle: Text("Calculadora IRT",
          style: TextStyle(color: Colors.black, fontSize: 14)),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(FontAwesomeIcons.thLarge, color: Colors.blueGrey, size: 16),
      ),
    );
  }

  Widget customHeader(String header) {
    return Container(
        margin: EdgeInsets.only(top: 15),
        child:
            Text(header, style: smallTextStyle(Colors.grey, FontWeight.w300)));
  }
}
