// ignore_for_file: avoid_relative_lib_imports

import 'package:test/test.dart';

import '../lib/client.dart';
import '../lib/invoice.dart';
import '../lib/invoice_filter.dart';
import '../lib/uf.dart';

void main() {
    test('lista de faturas vazia deve retornar vazio', () {
      final invoiceFilter = InvoiceFilter(invoiceList: []);
      expect(invoiceFilter.filter(), []);
    });

    test('lista de fatura com valores menores que 2000 deve retornar vazio', () {
      final invoiceFilter = InvoiceFilter(invoiceList: [Invoice(value: 100, client: Client(creationDate: DateTime.utc(2000), uf: UF.ba), date: DateTime.now()), Invoice(value: 1000, client: Client(creationDate: DateTime.utc(2000), uf: UF.ba), date: DateTime.now())]);
      expect(invoiceFilter.filter(), []);
    });

    test('deve remover faturas com valores entre 2000 e 2500 e com data menor ou igual dois meses', () {
      final invoiceWrong = Invoice(value: 2200, client: Client(creationDate: DateTime.utc(2000), uf: UF.ba), date: DateTime.now().subtract(Duration(days: 90)),);
      final invoiceCorrect = Invoice(value: 10000, client: Client(creationDate: DateTime.utc(2000), uf: UF.ba), date: DateTime.now(),);
      final invoiceFilter = InvoiceFilter(invoiceList: [invoiceWrong, invoiceCorrect]);
      expect(invoiceFilter.filter()[0], invoiceCorrect);
    });

    test('deve remover faturas com valores entre 2500 e 3000 e com cliente mais novo que 2 meses', () {
      final invoiceWrong = Invoice(value: 2700, client: Client(creationDate: DateTime.now(), uf: UF.ba), date: DateTime.now().subtract(Duration(days: 90)),);
      final invoiceCorrect = Invoice(value: 10000, client: Client(creationDate: DateTime.utc(2000), uf: UF.ba), date: DateTime.now(),);
      final invoiceFilter = InvoiceFilter(invoiceList: [invoiceWrong, invoiceCorrect]);
      expect(invoiceFilter.filter()[0], invoiceCorrect);
    });

    test('deve remover faturas com valores maiores que 4000 e com cliente do sudeste', () {
      final invoiceWrong = Invoice(value: 5000, client: Client(creationDate: DateTime.utc(2000), uf: UF.sp), date: DateTime.now(),);
      final invoiceCorrect = Invoice(value: 10000, client: Client(creationDate: DateTime.utc(2000), uf: UF.ba), date: DateTime.now(),);
      final invoiceFilter = InvoiceFilter(invoiceList: [invoiceWrong, invoiceCorrect]);
      expect(invoiceFilter.filter()[0], invoiceCorrect);
    });

}