import 'package:currencyapp/models/moeda.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
    Moeda(
        icone: "assets/images/bitcoin.png",
        nome: "Bitcoin",
        sigla: "BTC",
        preco: 164603.00),
    Moeda(
        icone: "assets/images/ethereum.png",
        nome: "Ethereum",
        sigla: "ETH",
        preco: 9716.00),
    Moeda(
        icone: "assets/images/xrp.png", nome: "XRP", sigla: "XRP", preco: 3.34),
    Moeda(
        icone: "assets/images/cardano.png",
        nome: "Cardano",
        sigla: "ADA",
        preco: 6.32),
    Moeda(
        icone: "assets/images/usd-coin.png",
        nome: "USD Coin",
        sigla: "USDC",
        preco: 5.02),
  ];


}
