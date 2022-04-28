import 'invoice.dart';
import 'uf.dart';

class InvoiceFilter {

  final List<Invoice> invoiceList;

  InvoiceFilter({this.invoiceList = const []});

  List<Invoice> filter() {
    final date = DateTime.now();
    invoiceList.removeWhere((invoice) => invoice.value < 2000);
    invoiceList.removeWhere((invoice) => invoice.value < 2500 && invoice.value > 2000 && invoice.date.isBefore(DateTime(date.year, date.month - 1, date.day)));
    invoiceList.removeWhere((invoice) => invoice.value < 3000 && invoice.value > 2500 && invoice.client.creationDate.isAfter(DateTime(date.year, date.month - 2, date.day)));
    invoiceList.removeWhere((invoice) => invoice.value > 4000 && (invoice.client.uf == UF.es || invoice.client.uf == UF.sp || invoice.client.uf == UF.rj || invoice.client.uf == UF.mg));
    return invoiceList;
  }
}