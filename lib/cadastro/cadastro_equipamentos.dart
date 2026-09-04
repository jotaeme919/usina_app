import 'package:flutter/material.dart';
import '../models/equipamentos.dart';
import '../models/unidade.dart';

class CadastroEquipamentoPage extends StatefulWidget {
  const CadastroEquipamentoPage({super.key});

  @override
  State<CadastroEquipamentoPage> createState() =>
      _CadastroEquipamentoPageState();
}

class _CadastroEquipamentoPageState
    extends State<CadastroEquipamentoPage> {

  final formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final unidadeController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    unidadeController.dispose();
    super.dispose();
  }

  void salvar() {
    if (formKey.currentState!.validate()) {
      final unidade = Unidade(
        id: int.parse(unidadeController.text.trim()),
        nome: 'Unidade',
      );

      final equipamento = Equipamento(
        id: 1,
        nome: nomeController.text.trim(),
        unidade: unidade,
      );

      print('ID: ${equipamento.id}');
      print('Nome: ${equipamento.nome}');
      print('Unidade: ${equipamento.unidade.nome}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Equipamento cadastrado com sucesso!',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Equipamento'),
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

              const SizedBox(height: 16),

              TextFormField(
                controller: unidadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ID da Unidade',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe a unidade';
                  }

                  if (int.tryParse(valor.trim()) == null) {
                    return 'Informe um ID válido';
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