import 'package:atividade5/fatura.dart';
import 'package:atividade5/nota_fiscal.dart';

abstract class NotaFiscalDao {
  void save(NotaFiscal nota);
}

class NotaFiscalDaoImpl extends NotaFiscalDao {

  @override
  void save(NotaFiscal nota) {
    print("salvando $nota no banco");
  }
}