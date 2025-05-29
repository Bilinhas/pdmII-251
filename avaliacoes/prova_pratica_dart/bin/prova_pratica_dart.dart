import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'dart:convert';

class Cliente{
  int codigo;
  String nome;
  int tipoCliente;

  Cliente({
    required this.codigo,
    required this.nome,
    required this.tipoCliente
  });

  Map<String, dynamic> toJson() => {
    "código": codigo,
    "descrição": nome,
    "Tipo Cliente": tipoCliente
  };
}

class Vendedor{
  int codigo;
  String nome;
  double comissao;

  Vendedor({
    required this.codigo,
    required this.nome,
    required this.comissao
  });

  Map<String, dynamic> toJson() => {
    "codigo": codigo,
    "nome": nome,
    "comissao": comissao
  };
}

class ItemPedido{
  int sequencial;
  String descricao;
  int quantidade;
  double valor = 0;

  ItemPedido({
    required this.sequencial,
    required this.descricao,
    required this.quantidade,
    required this.valor
  });

  Map<String, dynamic> toJson() => {
    "sequencial": sequencial,
    "descricao": descricao,
    "quantidade": quantidade,
    "valor": valor
  };
}

class Veiculo{
  int codigo;
  String descricao;
  double valor;

  Veiculo({
    required this.codigo,
    required this.descricao,
    required this.valor
  });

  Map<String, dynamic> toJson() => {
    "codigo": codigo,
    "descricao": descricao,
    "valor": valor
  };
}

class PedidoVenda {
  String codigo;
  DateTime data;
  double valorPedido;
  Cliente cli;
  Veiculo veic;
  Vendedor vend;
  List<ItemPedido> total;

  PedidoVenda({
    required this.codigo,
    required this.data,
    this.valorPedido = 0.0,
    required this.cli,   
    required this.veic,
    required this.vend,
    required this.total,
  });

  double calcularPedido() {
  double valor = 0.0;
  for (var t in total) {
    valor += t.valor * t.quantidade;
  }
  valor += veic.valor;
  return valor;
}

  Map<String, dynamic> toJson() => {
    "Código": codigo,
    "Data": data.toIso8601String(),
    "Valor do pedido": valorPedido,
    "Cliente": cli.toJson(), 
    "Vendedor": vend.toJson(),
    "Veículo": veic.toJson(),
    "Total": total
        .map((item) => item.toJson())
        .toList(), 
  };
}

main() async {
  Cliente cli = Cliente(codigo: 123, nome: "Kauã Leite", tipoCliente: 1);
  Vendedor vend = Vendedor(codigo: 456, nome: "Isaque Brito", comissao: 5.0);
  Veiculo voyage = Veiculo(codigo: 2015702, descricao: "Volkswagen Voyage de 2015, motores 1.0 e 1.6, acabamento com Trendline, Comfortline, Seleção, Highline e Evidence.", valor: 50000.00);
  ItemPedido chaveiro = ItemPedido(sequencial: 1, descricao: "Impossível se esquecer ;)", quantidade: 1, valor: 5.90);
  ItemPedido antena = ItemPedido(sequencial: 2, descricao: "Cuidado com a cabeça.", quantidade: 1, valor: 67.25);
  ItemPedido pneu = ItemPedido(sequencial: 3, descricao: "Sua melhor direção.", quantidade: 4, valor: 400.00);

  PedidoVenda pedido = PedidoVenda(codigo: "2015702123", data: DateTime.parse('2025-05-29 15:50'), cli: cli, vend: vend, veic: voyage, total: [chaveiro, antena, pneu]);
  pedido.valorPedido = pedido.calcularPedido();

  String pedidoJson = jsonEncode(pedido.toJson());

  final smtpServer = gmail('gabriel.alencar63@aluno.ifce.edu.br', 'lpqs oazz vvvc gvlo');

  final message = Message()
    ..from = Address('gabriel.alencar63@aluno.ifce.edu.br', 'Gabriel Alencar')
    ..recipients.add('taveira@ifce.edu.br')
    ..subject = 'Prova Prática'
    ..text = 'Teste de PDMII em JSON:\n\n$pedidoJson';

  try {
    final sendReport = await send(message, smtpServer);
    print('E-mail enviado: ${sendReport}');
  } on MailerException catch (e) {
    print('Erro ao enviar e-mail: ${e.toString()}');
  }
}