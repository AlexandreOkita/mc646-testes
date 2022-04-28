import 'package:atividade5/nota_fiscal.dart';

abstract class Smtp {
  void envia(NotaFiscal nf);
} 

class SmtpImpl extends Smtp {
  @override
  void envia(NotaFiscal nf) {
    print("Enviando para SAP");
  }
  
}