import 'package:atividade5/fatura.dart';
import 'package:atividade5/gerador_notas_fiscais.dart';
import 'package:atividade5/nota_fiscal_dao.dart';
import 'package:atividade5/sap.dart';
import 'package:atividade5/servico.dart';
import 'package:atividade5/smtp.dart';

void main(List<String> arguments) {
  final sap = SapImpl();
  final smtp = SmtpImpl();
  final nfDao = NotaFiscalDaoImpl();

  final gerador = GeradorNotasFiscais(notaFiscalDao: nfDao, sap: sap, smtp: smtp);

  gerador.gerarNota(Fatura(nome: "okita", valor: 100, servico: Servico.consultoria));
}
