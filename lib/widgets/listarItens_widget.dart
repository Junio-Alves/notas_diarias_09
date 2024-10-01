import 'package:flutter/material.dart';
import 'package:myapp/widgets/deleteDialog_widget.dart';
import 'package:myapp/widgets/editDialog_widget.dart';

class ListarItens extends StatefulWidget {
  final BuildContext context;
  final Map<String, dynamic> tarefa;
  final int index;
  final Function(int) deletar;
  final Function(int, String, String) editar;
  const ListarItens({
    super.key,
    required this.context,
    required this.tarefa,
    required this.index,
    required this.deletar,
    required this.editar,
  });

  @override
  State<ListarItens> createState() => _ListarItensState();
}

class _ListarItensState extends State<ListarItens> {
  final tarefaEditController = TextEditingController();
  final descricaoEditCOntroller = TextEditingController();

  @override
  void initState() {
    tarefaEditController.text = widget.tarefa["titulo"];
    descricaoEditCOntroller.text = widget.tarefa["descricao"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.tarefa["titulo"]),
        subtitle:
            Text("${widget.tarefa["date"]} - ${widget.tarefa["descricao"]}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              //EDITAR
              onPressed: () => showEditDialog(
                context,
                tarefaEditController,
                descricaoEditCOntroller,
                widget.editar,
                widget.tarefa,
              ),
              icon: const Icon(
                Icons.edit,
                color: Colors.green,
              ),
            ),
            IconButton(
              //DELETAR
              onPressed: () => showDeleteDialog(
                context,
                widget.deletar,
                widget.tarefa,
              ),
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
