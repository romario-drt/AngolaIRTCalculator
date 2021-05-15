import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/ui/common.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double baseSalary;
  double taxableIncome;

  TextEditingController baseSalaryController = TextEditingController();
  TextEditingController taxableIncomeController = TextEditingController();

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
                      Container(
                          margin: EdgeInsets.only(top: 25),
                          child: Text("Salário Base",
                              style: smallTextStyle(
                                  Colors.grey, FontWeight.w300))),
                      customTextField(baseSalaryController),

                      //subsidio tributavel
                      Container(
                          margin: EdgeInsets.only(top: 25),
                          child: Text("Subsídio Tributável",
                              style: smallTextStyle(
                                  Colors.grey, FontWeight.w300))),
                      customTextField(taxableIncomeController),
                    ],
                  ),
                )),

            //result table
            Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      resultListHeader("Tabela de Resultados",
                          Icon(Icons.keyboard_arrow_down)),
                      resultListItem("Valor Bruto", "0.00 AOA", mTextColor),
                      resultListItem("INSS", "0.00 AOA", mTextColor),
                      resultListItem(
                          "Valor Tributavel", "0.00 AOA", mTextColor),
                      resultListItem("IRT", "0.00 AOA", mTextColor),
                      resultListItem("Valor Liquido", "0.00 AOA", Colors.green),

                      //additional information
                      SizedBox(height: 15),
                      resultListHeader("Informação Adicional",
                          Icon(Icons.keyboard_arrow_down)),
                      resultListItem("Parcela Fixe", "0.00 AOA", mTextColor),
                      resultListItem("Excesso", "0.00 AOA", mTextColor),
                      resultListItem("Taxa", "10%", mTextColor),
                    ],
                  ),
                )),

            //button
            customFullButton(context, 'Calcular IRT')
          ],
        ),
      ),
    );
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

  Widget resultListItem(String title, String data, Color color) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      child: ListTile(
        minLeadingWidth: 0,
        leading: Icon(Icons.info_outline, color: mTextColor),
        title: Text(title, style: TextStyle(color: Colors.grey, fontSize: 14)),
        trailing: Text(data,
            style: TextStyle(
                color: color, fontSize: 14, fontWeight: FontWeight.bold)),
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
}
