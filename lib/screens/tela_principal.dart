import 'package:flutter/material.dart';

import '../cadastro/cadastro_indicador.dart';
import '../cadastro/cadastro_safra.dart';
import '../cadastro/cadastro_unidade.dart';
import '../cadastro/cadastro_equipamentos.dart';
import '../cadastro/cadastro_medicao.dart';
import '../cadastro/cadastro_unidademedida.dart';
import '../cadastro/cadastro_tipoinformacao.dart';
import '../cadastro/cadastro_usuario.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  bool cadastroAberto = false;

  Widget montarMenu() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          child: Text(
            'Menu Principal',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),

        const ListTile(
          leading: Icon(Icons.home),
          title: Text('Início'),
        ),

        ListTile(
          leading: const Icon(
            Icons.app_registration,
          ),
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
            leading: const Icon(
              Icons.chevron_right,
            ),
            title: const Text('Safra'),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const CadastroSafraPage(),
                ),
              );
            },
          ),

          // UNIDADE
          ListTile(
            leading: const Icon(
              Icons.chevron_right,
            ),
            title: const Text('Unidade'),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const CadastroUnidadePage(),
                ),
              );
            },
          ),

          // SETOR
          const ListTile(
            leading: Icon(
              Icons.chevron_right,
            ),
            title: Text('Setor'),
          ),

          // EQUIPAMENTO
          ListTile(
            leading: const Icon(
              Icons.chevron_right,
            ),
            title: const Text('Equipamento'),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const CadastroEquipamentoPage(),
                ),
              );
            },
          ),

          // MEDIÇÃO
          ListTile(
            leading: const Icon(
              Icons.chevron_right,
            ),
            title: const Text('Medição'),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const CadastroMedicaoPage(),
                ),
              );
            },
          ),

          // UNIDADE DE MEDIDA
          ListTile(
            leading: const Icon(
              Icons.chevron_right,
            ),
            title: const Text(
              'Unidade de Medida',
            ),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const CadastroUnidadeMedidaPage(),
                ),
              );
            },
          ),

          // TIPO DE INFORMAÇÃO
          ListTile(
            leading: const Icon(
              Icons.chevron_right,
            ),
            title: const Text(
              'Tipo de Informação',
            ),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const CadastroTipoInformacaoPage(),
                ),
              );
            },
          ),

          // INDICADOR
          ListTile(
            leading: const Icon(
              Icons.chevron_right,
            ),
            title: const Text('Indicador'),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const CadastroIndicadorPage(),
                ),
              );
            },
          ),

          // FUNCIONÁRIO
          const ListTile(
            leading: Icon(
              Icons.chevron_right,
            ),
            title: Text('Funcionário'),
          ),

          // TIPO DE MEDIÇÃO
          const ListTile(
            leading: Icon(
              Icons.chevron_right,
            ),
            title: Text('Tipo de Medição'),
          ),

          // PARÂMETRO
          const ListTile(
            leading: Icon(
              Icons.chevron_right,
            ),
            title: Text('Parâmetro'),
          ),
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Text('Usuário'),
            onTap: () {
            Navigator.pop(context);
            Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) =>
            const CadastroUsuarioPage(),
          ),
);
},
),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usina App'),
      ),

      drawer: Drawer(
        child: montarMenu(),
      ),

      body: const Center(
        child: Text(
          'Tela Principal',
        ),
      ),
    );
  }
}