// import 'package:currencyapp/helpers/styles.dart';
import 'package:currencyapp/models/moeda.dart';
import 'package:currencyapp/pages/moedas_detalhes_pages.dart';
import 'package:currencyapp/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  final String title;
  const Home({super.key, required this.title});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var tabela = MoedaRepository.tabela;
  bool isSorted = false;
  sort() {
    if (!isSorted) {
      tabela.sort((Moeda a, Moeda b) => a.nome.compareTo(b.nome));
      isSorted = true;
    } else {
      tabela = tabela.reversed.toList();
    }
  }

  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  var moeda = [];
  List<Moeda> selecionadas = [];

  appBarDinamic() {
    if (selecionadas.isEmpty) {
      return AppBar(
        elevation: 5,
        actions: [
          IconButton(
              onPressed: () => sort(),
              icon: const Icon(Icons.swap_vert_circle, color: Colors.white))
        ],
        leading: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Texting Icon'),
            ));
          },
          icon: const Icon(Icons.menu, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      );
    } else {
      return AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text("${selecionadas.length}",
            style: const TextStyle(color: Colors.white, fontSize: 15)),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      );
    }
  }

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
        context,
        MaterialPageRoute(
          
          builder: (_) => MoedasDetalhesPages(moeda: moeda),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDinamic(),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int moeda) {
            return ListTile(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              leading: (selecionadas.contains(tabela[moeda]))
                  ? const CircleAvatar(
                      child: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    )
                  : SizedBox(
                      width: 40, child: Image.asset(tabela[moeda].icone)),
              title: Text(
                tabela[moeda].nome,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.indigo,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Text(real.format(tabela[moeda].preco)),
              selected: selecionadas.contains(tabela[moeda]),
              selectedTileColor: Colors.indigo.withAlpha(20),
              onLongPress: () {
                setState(() {
                  (selecionadas.contains(tabela[moeda]))
                      ? selecionadas.remove(tabela[moeda])
                      : selecionadas.add(tabela[moeda]);
                });
              },
              onTap: () => mostrarDetalhes(tabela[moeda]),
            );
          },
          padding: const EdgeInsets.all(10),
          separatorBuilder: (_, ___) => const Divider(),
          itemCount: tabela.length),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(
                Icons.star,
                color: Colors.white,
              ),
              backgroundColor: Colors.indigo,
              label: const Text(
                'FAVORITAR',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            )
          : null,
    );
  }
}
