import 'package:sqlite3/sqlite3.dart';
import 'dart:io';

void main() {
  final db = sqlite3.open('alunos.db');

  db.execute('''
  CREATE TABLE IF NOT EXISTS TB_ALUNO(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL CHECK(length(nome) <= 50)
  );
  ''');

  while(true) {
    print('\nMenu:');
    print('1 - Inserir aluno');
    print('2 - Listar alunos');
    print('0 - Sair');
    stdout.write('Escolha uma opção: ');

    String? opcao = stdin.readLineSync();

    if (opcao == '1') {
      inserirAluno(db);
    } else if (opcao == '2') {
      listarAlunos(db);
    } else if (opcao == '0') {
      print('Encerrando o programa...');
      break;
    } else {
      print('Opção inválida.');
    }
  }

  db.dispose();
}


void inserirAluno(Database db) {
  stdout.write('Digite o nome do aluno (máximo 50 caracteres): ');
  String? nome = stdin.readLineSync();

  if (nome == null || nome.isEmpty || nome.length > 50) {
    print('Nome inválido, tente novamente.');
    return;
  }

  final stmt = db.prepare('INSERT INTO TB_ALUNO (nome) VALUES (?);');
  stmt.execute([nome]);
  stmt.dispose();
  print('Aluno inserido com sucesso!');
}

void listarAlunos(Database db) {
  final ResultSet result = db.select('SELECT id, nome FROM TB_ALUNO;');

  if (result.isEmpty) {
    print('Nenhum aluno cadastrado.');
    return;
  }

  print('Lista de alunos cadastrados:');
  for (final row in result) {
    print('ID: ${row['id']} - Nome: ${row['nome']}');
  }
}
