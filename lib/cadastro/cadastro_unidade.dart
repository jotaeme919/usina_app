import 'package:flutter/material.dart';
import '../models/unidade.dart';

class CadastroUnidadePage extends StatefulWidget {
  const CadastroUnidadePage({super.key});

  @override
  State<CadastroUnidadePage> createState() =>
      _CadastroUnidadePageState();
}

class _CadastroUnidadePageState
    extends State<CadastroUnidadePage> {

  final formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  void salvar() {
    if (formKey.currentState!.validate()) {
      final unidade = Unidade(
        id: 1,
        nome: nomeController.text.trim(),
      );

      print('ID: ${unidade.id}');
      print('Nome: ${unidade.nome}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unidade cadastrada com sucesso!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Unidade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o nome';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: salvar,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}