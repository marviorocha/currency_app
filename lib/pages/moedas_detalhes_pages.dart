import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../models/moeda.dart';

// ignore: must_be_immutable
class MoedasDetalhesPages extends StatefulWidget {
  Moeda moeda;
  MoedasDetalhesPages({super.key, required this.moeda});

  @override
  State<MoedasDetalhesPages> createState() => _MoedasDetalhesPagesState();
}

class _MoedasDetalhesPagesState extends State<MoedasDetalhesPages> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 17,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.moeda.nome,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  child: Image.asset(widget.moeda.icone),
                ),
                Container(width: 10),
                Text(
                  real.format(widget.moeda.preco),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),

              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'quantidade ${widget.moeda.sigla}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _valor,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Valor',
                        prefixIcon: Icon(Icons.monetization_on),
                        suffix: Text('reais', style: TextStyle(fontSize: 14)),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o valor da compra';
                        } else if (double.parse(value) < 50) {
                          return 'Compra mínima é R\$ 50,00';
                        }
                        return null;
                      },
                    onChanged: (value) {
                        setState(() {
                          quantidade = (value.isEmpty)
                              ? 0
                              : double.parse(value) / widget.moeda.preco;
                        });
                      },
                    ),
                    // Other form fields can be added here
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
