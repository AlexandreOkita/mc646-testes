import 'package:atividade5/fatura.dart';
import 'package:atividade5/gerador_notas_fiscais.dart';
import 'package:atividade5/nota_fiscal_dao.dart';
import 'package:atividade5/sap.dart';
import 'package:atividade5/servico.dart';
import 'package:atividade5/smtp.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';


class MockNotaFiscalDao extends Mock implements NotaFiscalDao {}
class MockSap extends Mock implements Sap {}
class MockSmtp extends Mock implements Smtp {}

void main() {
  final notaFiscalDao = MockNotaFiscalDao();
  final sap = MockSap();
  final smtp = MockSmtp();
  final gerador = GeradorNotasFiscais(notaFiscalDao: notaFiscalDao, sap: sap, smtp: smtp);

  test('uma fatura sem serviço específico deve criar uma nota com o mesmo nome, valor e imposto de 6%', () {
    final fatura = Fatura(nome: "teste", valor: 100, servico: Servico.outros);
    final notaFiscal = gerador.gerarNota(fatura);

    expect(notaFiscal.nome, "teste");
    expect(notaFiscal.valor, 100);
    expect(notaFiscal.imposto, 6);
  });

  test('uma fatura com o tipo CONSULTORIA deve gerar um imposto com 25% do valor', () {
    final fatura = Fatura(nome: "teste", valor: 100, servico: Servico.consultoria);
    final notaFiscal = gerador.gerarNota(fatura);

    expect(notaFiscal.imposto, 25);
  });

  test('uma fatura com o tipo TREINAMENTO deve gerar um imposto com 15% do valor', () {
    final fatura = Fatura(nome: "teste", valor: 100, servico: Servico.treinamento);
    final notaFiscal = gerador.gerarNota(fatura);

    expect(notaFiscal.imposto, 15);
  });

  test('quando gerada uma fatura, ela deve ser salva no banco de dados', () {
    
    final fatura = Fatura(nome: "teste", valor: 100, servico: Servico.treinamento);
    final notaFiscal = gerador.gerarNota(fatura);

    verify(() => notaFiscalDao.save(notaFiscal)).called(1);
  });

  test('quando gerada uma fatura, ela deve ser enviada para o SAP', () {
    
    final fatura = Fatura(nome: "teste", valor: 100, servico: Servico.treinamento);
    final notaFiscal = gerador.gerarNota(fatura);

    verify(() => sap.envia(notaFiscal)).called(1);
  });

  test('quando gerada uma fatura, ela deve ser enviada via email', () {
    
    final fatura = Fatura(nome: "teste", valor: 100, servico: Servico.treinamento);
    final notaFiscal = gerador.gerarNota(fatura);

    verify(() => smtp.envia(notaFiscal)).called(1);
  });
}