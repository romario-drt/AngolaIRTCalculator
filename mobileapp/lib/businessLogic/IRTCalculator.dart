import 'businessLogic/../Division.dart';

class IRTCalculator {
  List<Division> divisions = [];

  double grossIncome = 0;
  double inss = 0;
  double taxableAmount = 0;
  double irt = 0;
  double netSalary = 0;

  double fixedParcel = 0;
  double excess = 0;
  double tax = 0;

  IRTCalculator() {
    _init();
  }

  String toString() {
    return "[valor tributavel:$taxableAmount],[inss:$inss],[irt:$irt],[Valor Liquido: $netSalary]";
  }

  //calculate IRT
  void calculate(double salarioBase, [double totalsubsidioTributavel = 0]) {
    this.grossIncome = salarioBase + totalsubsidioTributavel;
    Division division = this._getDivision(grossIncome);

    this.fixedParcel = division.fixedParcel;
    this.excess = division.excess;
    this.tax = division.tax;

    //INSS is always 3% of gross income
    this.inss = grossIncome * 0.03;
    this.taxableAmount = grossIncome - this.inss;
    this.irt = fixedParcel + ((taxableAmount - excess) * (tax / 100));
    this.netSalary = taxableAmount - irt;
  }

  //return the division to operate
  Division _getDivision(double grossIncome) {
    for (Division d in divisions) {
      if (grossIncome <= d.max) return d;
    }
    return divisions.last;
  }

  //carregar carga de escalao
  void _init() {
    divisions.addAll([
      Division(1, 00000, 70000, 0, 0, 0),
      Division(2, 70001, 100000, 3000, 10, 70000),
      Division(3, 100001, 150000, 6000, 13, 100000),
      Division(4, 150001, 200000, 12500, 16, 150000),
      Division(5, 200001, 300000, 31250, 18, 200000),
      Division(6, 300001, 500000, 49250, 19, 300000),
      Division(7, 500001, 1000000, 87250, 20, 500000),
      Division(8, 1000001, 1500000, 187250, 21, 1000000),
      Division(9, 1500001, 2000000, 292000, 22, 1500000),
      Division(10, 2000001, 2500000, 402250, 23, 2000000),
      Division(11, 2500001, 5000000, 517250, 24, 2500000),
      Division(12, 5000001, 10000000, 1117250, 24.5, 5000000),
      Division(13, 10000001, 0, 2342250, 25, 10000000)
    ]);
  }
}
