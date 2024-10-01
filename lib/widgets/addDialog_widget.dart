import 'package:flutter/material.dart';

Future showAddDialog(
  BuildContext context,
  TextEditingController tarefaController,
  TextEditingController descricaoController,
  VoidCallback salvar,
) {
  final formKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          "Adicionar Anotação",
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: tarefaController,
                decoration: const InputDecoration(
                  label: Text("Tarefa"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Tarefa é obrigatorio!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descricaoController,
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
                salvar();
                Navigator.pop(context);
              }
            },
            child: const Text("Confirmar"),
          ),
        ],
      );
    },
  );
}
