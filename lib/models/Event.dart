class Event{
  late String nome;
  late String idMinisterio;
  late String idEvento;
  List<dynamic>musicas = [];

  late String observacoes;
  late List<dynamic> integrantes;

  Event(String nomeEvento,List<dynamic> musicasEvento,String idEvent,
   String idMinistery, String observacoesDoEvento,
  List<dynamic> integrantesdoEvento) {
    nome = nomeEvento;
    musicas = musicasEvento; 
    idEvento = idEvent; 
    idMinisterio = idMinistery;
 
    observacoes = observacoesDoEvento;
    integrantes = integrantesdoEvento;
  }

  @override
  String toString() {
    return 'Event{nome: $nome, idMinisterio: $idMinisterio, idEvento: $idEvento, musicas: $musicas, observacoes: $observacoes, integrantes: $integrantes}';
  }
}