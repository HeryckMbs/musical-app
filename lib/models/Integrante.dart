class Integrante{
  late String nome;
  late String idIntegrante;
  late String idMinisterio;
  late List<dynamic> idfuncoes;
  bool selecionado = false;
  late bool active;

 
  Integrante(String nomeIntegrante, String id, String idMinisterioRequest, List<dynamic> idfuncoesreq,bool ativo ) {
    nome = nomeIntegrante;
    idIntegrante = id;
    idMinisterio = idMinisterioRequest;
    idfuncoes = idfuncoesreq;
    active = ativo;
  }

}