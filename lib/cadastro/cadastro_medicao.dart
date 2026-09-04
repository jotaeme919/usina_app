import 'package:flutter/material.dart';

import '../models/medicao.dart';
import '../models/safra.dart';
import '../models/unidade.dart';
import '../models/tipoinformacao.dart';
import '../models/unidademedida.dart';

class CadastroMedicaoPage extends StatefulWidget {
  const CadastroMedicaoPage({super.key});

  @override
  State<CadastroMedicaoPage> createState() =>
      _CadastroMedicaoPageState();
}

class _CadastroMedicaoPageState
    extends State<CadastroMedicaoPage> {

  final formKey = GlobalKey<FormState>();

  final safraController = TextEditingController();
  final unidadeController = TextEditingController();
  final tipoInformacaoController = TextEditingController();
  final valorController = TextEditingController();

  @override
  void dispose() {
    safraController.dispose();
    unidadeController.dispose();
    tipoInformacaoController.dispose();
    valorController.dispose();

    super.dispose();
  }

  void salvar() {
    if (formKey.currentState!.validate()) {

      // Criando uma Safra
      final safra = Safra(
        id: int.parse(safraController.text.trim()),
        nome: 'Safra',
        dataInicio: DateTime.now(),
        dataFim: DateTime.now(),
      );

      // Criando uma Unidade
      final unidade = Unidade(
        id: int.parse(unidadeController.text.trim()),
        nome: 'Unidade',
      );

      // Criando uma Unidade de Medida
      final unidadeMedida = UnidadeMedida(
        id: 1,
        nome: 'Unidade',
        simbolo: 'un',
      );

      // Criando um Tipo de Informação
      final tipoInformacao = TipoInformacao(
        id: int.parse(
          tipoInformacaoController.text.trim(),
        ),
        nome: 'Tipo de Informação',
        unidademedida: unidadeMedida,
      );

      // Criando a Medição
      final medicao = Medicao(
        id: 1,
        safra: safra,
        unidade: unidade,
        tipoinformacao: tipoInformacao,
        valor: int.parse(
          valorController.text.trim(),
        ),
      );

      print('ID: ${medicao.id}');
      print('Safra: ${medicao.safra.nome}');
      print('Unidade: ${medicao.unidade.nome}');
      print(
        'Tipo de Informação: '
        '${medicao.tipoinformacao.nome}',
      );
      print('Valor: ${medicao.valor}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Medição cadastrada com sucesso!',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Medição'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: formKey,

          child: Column(
            children: [

              TextFormField(
                controller: safraController,
                keyboardType: TextInputType.number,

                decoration: const InputDecoration(
                  labelText: 'ID da Safra',
                  border: OutlineInputBorder(),
                ),

                validator: (valor) {
                  if (valor == null ||
                      valor.trim().isEmpty) {
                    return 'Informe o ID da safra';
                  }

                  if (int.tryParse(
                        valor.trim(),
                      ) ==
                      null) {
                    return 'Informe um ID válido';
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
                  if (valor == null ||
                      valor.trim().isEmpty) {
                    return 'Informe o ID da unidade';
                  }

                  if (int.tryParse(
                        valor.trim(),
                      ) ==
                      null) {
                    return 'Informe um ID válido';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: tipoInformacaoController,
                keyboardType: TextInputType.number,

                decoration: const InputDecoration(
                  labelText: 'ID do Tipo de Informação',
                  border: OutlineInputBorder(),
                ),

                validator: (valor) {
                  if (valor == null ||
                      valor.trim().isEmpty) {
                    return 'Informe o ID do tipo de informação';
                  }

                  if (int.tryParse(
                        valor.trim(),
                      ) ==
                      null) {
                    return 'Informe um ID válido';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: valorController,
                keyboardType: TextInputType.number,

                decoration: const InputDecoration(
                  labelText: 'Valor',
                  border: OutlineInputBorder(),
                ),

                validator: (valor) {
                  if (valor == null ||
                      valor.trim().isEmpty) {
                    return 'Informe o valor';
                  }

                  if (int.tryParse(
                        valor.trim(),
                      ) ==
                      null) {
                    return 'Informe um número inteiro';
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