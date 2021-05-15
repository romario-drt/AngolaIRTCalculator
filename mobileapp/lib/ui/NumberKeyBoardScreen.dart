import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common.dart';

class NumberKeyBoardScreen extends StatefulWidget {
  @override
  _NumberKeyBoardScreenState createState() => _NumberKeyBoardScreenState();
}

class _NumberKeyBoardScreenState extends State<NumberKeyBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: simpleAppBar(context),
        body: Column(
          children: [
            Text(
                "Salário é a palavra que se refere à renumeração que recebe de maneira periódica um trabalhador como consequência da prestação de um serviço profissional ou desempenho de um cargo"),
            FittedBox(
                fit: BoxFit.fitWidth,
                child: Text('Hey this is my long text appbar title')),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                keyBoardRow([numberKey('1'), numberKey('2'), numberKey('3')]),
                SizedBox(height: 30),
                keyBoardRow([numberKey('4'), numberKey('5'), numberKey('6')]),
                SizedBox(height: 30),
                keyBoardRow([numberKey('7'), numberKey('8'), numberKey('9')]),
                SizedBox(height: 30),
                keyBoardRow([numberKey('D'), numberKey('0'), numberKey('C')])
              ],
            )),
            customFullButton(context, "Adicionar Valor")
          ],
        ),
      ),
    );
  }
}

Widget keyBoardRow(List<Widget> keys) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: keys,
  );
}

Widget numberKey(String value) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.all(5),
      child: Text(
        value,
        style: TextStyle(
            color: mTextColor, fontSize: 25, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

//onTap: () => Navigator.pop(context, double.parse('100000')),
