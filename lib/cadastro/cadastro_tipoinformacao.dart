import 'package:flutter/material.dart';
import '../models/tipoinformacao.dart';
import '../models/unidademedida.dart';

class CadastroTipoInformacaoPage extends StatefulWidget {
  const CadastroTipoInformacaoPage({super.key});

  @override
  State<CadastroTipoInformacaoPage> createState() =>
      _CadastroTipoInformacaoPageState();
}

class _CadastroTipoInformacaoPageState
    extends State<CadastroTipoInformacaoPage> {

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
      final unidadeMedida = UnidadeMedida(
        id: int.parse(unidadeController.text.trim()),
        nome: 'Unidade',
        simbolo: 'un',
      );

      final tipoInformacao = TipoInformacao(
        id: 1,
        nome: nomeController.text.trim(),
        unidademedida: unidadeMedida,
      );

      print('ID: ${tipoInformacao.id}');
      print('Nome: ${tipoInformacao.nome}');
      print(
        'Unidade: ${tipoInformacao.unidademedida.nome}',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Tipo de informação cadastrado com sucesso!',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Tipo de Informação'),
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
                  labelText: 'ID da Unidade de Medida',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe a unidade de medida';
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