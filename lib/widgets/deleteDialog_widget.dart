import 'package:flutter/material.dart';

Future showDeleteDialog({
  required BuildContext context,
  required Function(int) deletar,
  required final Map<String, dynamic> tarefa,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Deseja mesmo deletar essa anotação?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("cancelar"),
          ),
          TextButton(
            onPressed: () {
              deletar(tarefa["ID"]);
              Navigator.pop(context);
            },
            child: const Text("Confirmar"),
          ),
        ],
      );
    },
  );
}
