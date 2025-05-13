// Agregação e Composição
import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  Map toJson () => {
    "nome":_nome
  };
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  Map toJson () => {
    "nome":_nome,
    "dependentes":_dependentes
  };
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  Map toJson () => {
    "nomeProjeto":_nomeProjeto,
    "funcionarios":_funcionarios
  };
}

void main() {
  // 1. Criar varios objetos Dependentes

  Dependente dep1 = Dependente("Kaua Leite");
  Dependente dep2 = Dependente("Joao Leite");
  Dependente dep3 = Dependente("Ismael Leite");
  Dependente dep4 = Dependente("Isaque Leite");
  Dependente dep5 = Dependente("Gabriel Cafe");

  // 2. Criar varios objetos Funcionario
  // 3. Associar os Dependentes criados aos respectivos
  //    funcionarios

  Funcionario fun1 = Funcionario("Joao Caetano", [dep1,dep2]);
  Funcionario fun2 = Funcionario("Rick Skull", [dep3,dep4]);
  Funcionario fun3 = Funcionario("Jose Rapunzel", [dep2,dep3,dep5]);
  Funcionario fun4 = Funcionario("Julius Cesaria", [dep1,dep3]);
  Funcionario fun5 = Funcionario("Sid Belchior", [dep4,dep5]);

  // 4. Criar uma lista de Funcionarios
  
  List<Funcionario> fun = [fun1,fun2,fun3,fun4,fun5];

  // 5. criar um objeto Equipe Projeto chamando o metodo
  //    contrutor que da nome ao projeto e insere uma
  //    coleção de funcionario

  EquipeProjeto EP = EquipeProjeto("TacOS", [fun1,fun2,fun3,fun4,fun5]);

  // 6. Printar no formato JSON o objeto Equipe Projeto.

  print(jsonEncode(EP));
}