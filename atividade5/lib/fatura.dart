import 'package:atividade5/servico.dart';

class Fatura {
  final String nome;
  final double valor;
  final Servico servico;

  Fatura({required this.nome, required this.valor, required this.servico});
}