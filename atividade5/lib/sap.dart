import 'package:atividade5/nota_fiscal.dart';

abstract class Sap {
  envia(NotaFiscal nf);
}

class SapImpl extends Sap {
  @override
  envia(NotaFiscal nf) {
    print("Enviando email");
  }

}