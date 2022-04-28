import 'package:atividade5/fatura.dart';
import 'package:atividade5/nota_fiscal.dart';
import 'package:atividade5/nota_fiscal_dao.dart';
import 'package:atividade5/sap.dart';
import 'package:atividade5/servico.dart';
import 'package:atividade5/smtp.dart';

class GeradorNotasFiscais {

  final NotaFiscalDao notaFiscalDao;
  final Sap sap;
  final Smtp smtp;

  GeradorNotasFiscais({required this.notaFiscalDao, required this.sap, required this.smtp});

  NotaFiscal gerarNota(Fatura fatura) {
    double impostoCalculado = fatura.valor * 0.06;

    if (fatura.servico == Servico.consultoria) {
      impostoCalculado = fatura.valor * 0.25;
    } else if (fatura.servico == Servico.treinamento) {
      impostoCalculado = fatura.valor * 0.15;
    }

    final nota = NotaFiscal(valor: fatura.valor, nome: fatura.nome, imposto: impostoCalculado);
    notaFiscalDao.save(nota);
    sap.envia(nota);
    smtp.envia(nota);
    return nota;
  }
}