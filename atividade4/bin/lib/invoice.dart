import 'client.dart';

class Invoice {
  final int value;
  final DateTime date;
  final Client client;

  Invoice({required this.value, required this.date, required this.client});

}