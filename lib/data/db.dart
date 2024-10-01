import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbsqflite {
  final table = "tarefas";

  //Função para abrir banco de dados
  Future<Database> openDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDaos = join(caminhoBancoDados, "banco.db");
    // Abre o banco de dados, criando a tabela se necessário
    return openDatabase(
      localBancoDaos,
      version: 1,
      //caso não exista, chama a função onCreate!
      onCreate: (db, version) {
        return db.execute('''
              CREATE TABLE $table(
              ID INTEGER PRIMARY KEY AUTOINCREMENT,
              titulo TEXT,
              descricao TEXT,
              date TEXT
              )''');
      },
    );
  }

  adicionarTarefa({
    required String titulo,
    required String descricao,
    required String date,
  }) async {
    final db = await openDB();
    db.insert(
      table,
      {
        "titulo": titulo,
        "descricao": descricao,
        "date": date,
      },
    );
  }

  Future<List<Map<String, dynamic>>> listarTarefas() async {
    final db = await openDB();
    return await db.query(table);
  }

  excluirTarefa(int id) async {
    final db = await openDB();
    db.delete(table, where: "ID = ?", whereArgs: [id]);
  }

  editarTarefa(int id, String novoTitulo, String novaDescricao) async {
    final db = await openDB();
    db.update(
        table,
        {
          "titulo": novoTitulo,
          "descricao": novaDescricao,
        },
        where: "ID = ?",
        whereArgs: [id]);
  }
}
