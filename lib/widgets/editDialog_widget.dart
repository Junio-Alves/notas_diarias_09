import 'package:flutter/material.dart';

Future showEditDialog(
  BuildContext context,
  TextEditingController tarefaEditController,
  TextEditingController descricaoEditController,
  Function(int, String, String) editar,
  final Map<String, dynamic> tarefa,
) {
  final formKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Editar Anotação"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: tarefaEditController,
                decoration: const InputDecoration(
                  label: Text("Tarefa"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo descrição é obrigatorio!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descricaoEditController,
                decoration: const InputDecoration(
                  label: Text("Descrição"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo descrição é obrigatorio!";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("cancelar"),
          ),
          TextButton(
            onPressed: () {
              //Validação dos campos de texto
              if (formKey.currentState!.validate()) {
                editar(
                  tarefa["ID"],
                  tarefaEditController.text,
                  descricaoEditController.text,
                );
                Navigator.pop(context);
              }
            },
            child: const Text("Atualizar"),
          ),
        ],
      );
    },
  );
}
