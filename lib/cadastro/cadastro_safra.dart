import 'package:flutter/material.dart';
import '../models/safra.dart';

class CadastroSafraPage extends StatefulWidget {
  const CadastroSafraPage({super.key});

  @override
  State<CadastroSafraPage> createState() =>
      _CadastroSafraPageState();
}

class _CadastroSafraPageState
    extends State<CadastroSafraPage> {

  final formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final dataInicioController = TextEditingController();
  final dataFimController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    dataInicioController.dispose();
    dataFimController.dispose();

    super.dispose();
  }

  void salvar() {
    if (formKey.currentState!.validate()) {

      final safra = Safra(
        id: 1,
        nome: nomeController.text.trim(),
        dataInicio: DateTime.parse(
          dataInicioController.text.trim(),
        ),
        dataFim: DateTime.parse(
          dataFimController.text.trim(),
        ),
      );

      print('ID: ${safra.id}');
      print('Nome: ${safra.nome}');
      print('Data início: ${safra.dataInicio}');
      print('Data fim: ${safra.dataFim}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Safra cadastrada com sucesso!',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Safra'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: formKey,

          child: Column(
            children: [

              TextFormField(
                controller: nomeController,

                decoration: const InputDecoration(
                  labelText: 'Nome da Safra',
                  border: OutlineInputBorder(),
                ),

                validator: (valor) {
                  if (valor == null ||
                      valor.trim().isEmpty) {
                    return 'Informe o nome da safra';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: dataInicioController,

                decoration: const InputDecoration(
                  labelText: 'Data de início',
                  hintText: '2026-01-01',
                  border: OutlineInputBorder(),
                ),

                validator: (valor) {
                  if (valor == null ||
                      valor.trim().isEmpty) {
                    return 'Informe a data de início';
                  }

                  if (DateTime.tryParse(
                        valor.trim(),
                      ) ==
                      null) {
                    return 'Informe uma data válida';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: dataFimController,

                decoration: const InputDecoration(
                  labelText: 'Data de fim',
                  hintText: '2026-12-31',
                  border: OutlineInputBorder(),
                ),

                validator: (valor) {
                  if (valor == null ||
                      valor.trim().isEmpty) {
                    return 'Informe a data de fim';
                  }

                  if (DateTime.tryParse(
                        valor.trim(),
                      ) ==
                      null) {
                    return 'Informe uma data válida';
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