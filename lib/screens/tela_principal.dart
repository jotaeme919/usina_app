
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cadastro/cadastro_indicador.dart';
import '../cadastro/cadastro_safra.dart';
import '../cadastro/cadastro_unidade.dart';
import '../cadastro/cadastro_equipamento.dart';
import '../cadastro/cadastro_medicao.dart';
import '../cadastro/cadastro_unidademedida.dart';
import '../cadastro/cadastro_tipoinformacao.dart';
import '../cadastro/cadastro_usuario.dart';

import '../models/indicador.dart';
import '../services/indicador_service.dart';
import 'indicadores_page.dart';
import 'indicador_webview.dart';
import 'login_page.dart';

import 'cruds/crud_safra_page.dart';
import 'cruds/crud_unidade_page.dart';
import 'cruds/crud_unidade_medida_page.dart';
import 'cruds/crud_equipamento_page.dart';
import 'cruds/crud_tipo_informacao_page.dart';
import 'cruds/crud_medicao_page.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  bool cadastroAberto = false;

  late Future<List<Indicador>> indicadores;

  @override
  void initState() {
    super.initState();
    indicadores = IndicadorService().listar();
  }

  void atualizarIndicadores() {
    if (!mounted) return;

    setState(() {
      indicadores = IndicadorService().listar();
    });
  }

  Widget montarMenu() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          child: Text(
            'Menu Principal',
            style: TextStyle(fontSize: 22),
          ),
        ),

        const ListTile(
          leading: Icon(Icons.home),
          title: Text('Início'),
        ),

        // MENU DE CADASTROS
        ListTile(
          leading: const Icon(Icons.app_registration),
          title: const Text('Cadastro'),
          trailing: Icon(
            cadastroAberto
                ? Icons.expand_less
                : Icons.expand_more,
          ),
          onTap: () {
            setState(() {
              cadastroAberto = !cadastroAberto;
            });
          },
        ),

        if (cadastroAberto) ...[
          // SAFRA
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Text('Safra'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CadastroSafraPage(),
                ),
              );
            },
          ),

          // UNIDADE
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Text('Unidade'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CadastroUnidadePage(),
                ),
              );
            },
          ),

          // SETOR
          const ListTile(
            leading: Icon(Icons.chevron_right),
            title: Text('Setor'),
          ),

          // EQUIPAMENTO
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Text('Equipamento'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CadastroEquipamentoPage(),
                ),
              );
            },
          ),

          // MEDIÇÃO
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Text('Medição'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CadastroMedicaoPage(),
                ),
              );
            },
          ),

          // UNIDADE DE MEDIDA
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Text('Unidade de Medida'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const CadastroUnidadeMedidaPage(),
                ),
              );
            },
          ),

          // TIPO DE INFORMAÇÃO
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Text('Tipo de Informação'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const CadastroTipoInformacaoPage(),
                ),
              );
            },
          ),

          // INDICADOR
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Text('Indicador'),
            onTap: () async {
              Navigator.pop(context);

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CadastroIndicadorPage(),
                ),
              );

              if (mounted) atualizarIndicadores();
            },
          ),

          // FUNCIONÁRIO
          const ListTile(
            leading: Icon(Icons.chevron_right),
            title: Text('Funcionário'),
          ),

          // TIPO DE MEDIÇÃO
          const ListTile(
            leading: Icon(Icons.chevron_right),
            title: Text('Tipo de Medição'),
          ),

          // PARÂMETRO
          const ListTile(
            leading: Icon(Icons.chevron_right),
            title: Text('Parâmetro'),
          ),

          // USUÁRIO
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Text('Usuário'),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CadastroUsuarioPage(),
                ),
              );
            },
          ),
        ],

        const Divider(),

        // GERENCIAR INDICADORES
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Gerenciar indicadores'),
          onTap: () async {
            Navigator.pop(context);

            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const IndicadoresPage(),
              ),
            );

            if (mounted) atualizarIndicadores();
          },
        ),

        // INDICADORES DINÂMICOS
        ExpansionTile(
          leading: const Icon(Icons.analytics),
          title: const Text('Indicadores'),
          children: [
            FutureBuilder<List<Indicador>>(
              future: indicadores,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const ListTile(
                    title: Text('Carregando...'),
                  );
                }

                if (snapshot.hasError) {
                  return const ListTile(
                    title: Text('Falha ao carregar indicadores'),
                  );
                }

                if (!snapshot.hasData) {
                  return const ListTile(
                    title: Text('Nenhum indicador'),
                  );
                }

                final lista = snapshot.data!;

                if (lista.isEmpty) {
                  return const ListTile(
                    title: Text('Nenhum indicador'),
                  );
                }

                return Column(
                  children: lista.map((item) {
                    return ListTile(
                      leading: const Icon(Icons.bar_chart),
                      title: Text(item.nome),
                      onTap: () {
                        Navigator.pop(context);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                IndicadorWebviewPage(
                              indicador: item,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),

        const Divider(),

        // SAIR DO APLICATIVO
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Sair'),
          onTap: sair,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usina App'),
      ),

      onDrawerChanged: (aberto) {
        if (aberto) {
          atualizarIndicadores();
        }
      },

      drawer: Drawer(
        child: montarMenu(),
      ),

      body: const Center(
        child: Text('Tela Principal'),
      ),
    );
  }

  // LOGOUT
  Future<void> sair() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('loginRealizado', false);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    );
  }
}
