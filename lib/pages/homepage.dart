import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/data/db.dart';
import 'package:myapp/widgets/addDialog_widget.dart';
import 'package:myapp/widgets/listarItens_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> tarefas = [];

  final db = Dbsqflite();
  final tarefaController = TextEditingController();
  final descricaoCOntroller = TextEditingController();
  final dateTime = DateTime.now();

  limparController() {
    tarefaController.text = "";
    descricaoCOntroller.text = "";
  }

  //Funções CRUD
  salvar() {
    final dataHoje = DateFormat("dd/MM/yyyy").format(dateTime);
    db.adicionarTarefa(
      titulo: tarefaController.text,
      descricao: descricaoCOntroller.text,
      date: dataHoje,
    );
    limparController();
    recuperar();
  }

  recuperar() async {
    final dbRecuperado = await db.listarTarefas();
    setState(() {
      tarefas = dbRecuperado;
    });
  }

  editar(int id, String novoTitulo, String novaDescricao) {
    db.editarTarefa(id, novoTitulo, novaDescricao);
    recuperar();
  }

  deletar(int id) {
    db.excluirTarefa(id);
    recuperar();
  }
  //Funções CRUD

  @override
  void initState() {
    recuperar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "Anotações",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        //Chama "showAddDialog" para adicionar nova anotação!
        onPressed: () => showAddDialog(
          context:context,
          tarefaController:tarefaController,
          descricaoController:descricaoCOntroller,
          salvar:salvar,
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tarefas.length,
              //Lista itens na tela
              itemBuilder: (context, index) => ListarItens(
                editar: editar,
                deletar: deletar,
                context: context,
                tarefa: tarefas[index],
                index: index,
              ),
            ),
          )
        ],
      ),
    );
  }
}
